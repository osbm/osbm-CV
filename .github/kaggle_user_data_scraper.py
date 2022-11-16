from selenium import webdriver
from webdriver_manager.chrome import ChromeDriverManager
from webdriver_manager.core.utils import ChromeType
from selenium.webdriver.chrome.options import Options
from selenium.webdriver.chrome.service import Service
from bs4 import BeautifulSoup
from PIL import Image, ImageColor, ImageDraw, ImageFont
import requests

import sys
import json
from pprint import pprint

debug = False

all_tiers = ["grandmaster", "master", "expert", "contributor", "novice"]
categories = ["competitions", "datasets", "notebooks", "discussions"]
tier_image_urls = {
    tier: f"https://kaggle.com/static/images/tiers/{tier}@96.png" for tier in all_tiers
}
tier_colors = {
    "grandmaster": "#DDAA17",
    "master": "#F76629",
    "expert": "#96508E",
    "contributor": "#20BEFF",
    "novice": "#4FCB93",
}

medal_image_urls = [
    "https://kaggle.com/static/images/medals/datasets/goldl@1x.png",
    "https://kaggle.com/static/images/medals/datasets/silverl@1x.png",
    "https://kaggle.com/static/images/medals/datasets/bronzel@1x.png",
]

medal_colors = [
    "#AD7615",
    "#838280",
    "#8E5B3D",
]


def get_medals(source):
    a = source.find_all("div", attrs={"class": "achievement-summary__medal"})
    medals = []
    for i in a:
        number = i.select("div > p")[1].get_text(strip=True)
        medals.append(int(number))

        # make the shape 4x3
    medals = [medals[i : i + 3] for i in range(0, len(medals), 3)]

    return medals


def get_tiers(source):
    a = source.find_all(
        "span",
        attrs={"class": "achievement-summary__title achievement-summary__title--link"},
    )
    tiers = []
    for i in a:
        result = i.select("span > span")[0].get_text(strip=True)
        tiers.append(result)

    return tiers


def get_rankings(source):
    a = source.find_all("div", attrs={"class": "achievement-summary__rank"})
    rankings = []
    for i in a:
        result = i.get_text(strip=True)
        if result == "Unranked":
            rankings.append(result)
            continue
        if "Highest Rank" in result:

            rankings.append(
                {
                    "best": result.split("Highest Rank")[1],
                    "current": result.split("Highest Rank")[0]
                    .split("of")[0]
                    .replace("Current Rank", ""),
                    "total": result.split("Highest Rank")[0].split("of")[1],
                }
            )
        else:
            print(a)
            print(rankings)
            exit()

    return rankings


def make_dict(source):
    medals = get_medals(source)
    tiers = get_tiers(source)
    rankings = get_rankings(source)
    return {
        "medals": medals,
        "tiers": tiers,
        "rankings": rankings,
    }


def get_driver():

    chrome_options_list = [
        "--headless",
        "--disable-gpu",
        "--window-size=1920,1200",
        "--ignore-certificate-errors",
        "--disable-extensions",
        "--no-sandbox",
        "--disable-dev-shm-usage",
    ]
    chrome_service = Service(
        ChromeDriverManager(chrome_type=ChromeType.GOOGLE).install()
    )
    chrome_options = Options()

    for option in chrome_options_list:
        chrome_options.add_argument(option)

    driver = webdriver.Chrome(service=chrome_service, options=chrome_options)
    return driver


def build_image(data, backgroud_color="#E7E7E7"):
    backgroud_color = ImageColor.getrgb(backgroud_color)
    size = (400, 800)
    image = Image.new("RGBA", size, backgroud_color)
    draw = ImageDraw.Draw(image)

    row_height = size[1] / 4

    tiers = data["tiers"]
    medals = data["medals"]
    rankings = data["rankings"]

    opensans_font = ImageFont.truetype("OpenSans-Bold.ttf", 25)

    for i in range(4):
        line_margin = 20
        category_text = categories[i].capitalize() + " " + tiers[i].capitalize()
        w, h = opensans_font.getsize(category_text)
        color = tier_colors[tiers[i]]

        text_w = int((size[0] - w) / 2)
        text_h = int(i * row_height + (row_height + h) / 8)
        draw.text((text_w, text_h - 10), category_text, font=opensans_font, fill=color)

        vertical_margin = 40

        # draw tier image
        tier_image = Image.open(
            requests.get(tier_image_urls[tiers[i]], stream=True).raw
        )
        tier_image_size = (100, 100)
        tier_image = tier_image.resize(tier_image_size)
        image.paste(
            tier_image,
            (2 * line_margin, text_h + vertical_margin),
            tier_image.convert("RGBA"),
        )

        # draw ranking

        remaining_space_coordinates = (
            2 * line_margin + tier_image_size[0] + line_margin,
            text_h + vertical_margin,
            size[0] - line_margin,
            text_h + vertical_margin + tier_image_size[1],
        )
        # draw rectangle at the remaining space
        # draw.rectangle(remaining_space_coordinates)

        remaining_space_w = (
            remaining_space_coordinates[2] - remaining_space_coordinates[0]
        )
        remaining_space_h = (
            remaining_space_coordinates[3] - remaining_space_coordinates[1]
        )

        if rankings[i] == "Unranked":
            msg = rankings[i]
            w, h = opensans_font.getsize(msg)
            text_w = int((remaining_space_w - w) / 2 + remaining_space_coordinates[0])
            text_h = int(
                (remaining_space_h / 2 - h) / 2 + remaining_space_coordinates[1]
            )
            draw.text((text_w, text_h), msg, font=opensans_font, fill=color)
        else:
            msg = rankings[i]["current"] + " of " + rankings[i]["total"]
            w, h = opensans_font.getsize(msg)
            text_w = int((remaining_space_w - w) / 2 + remaining_space_coordinates[0])
            text_h = int(
                (remaining_space_h / 2 - h) / 2 + remaining_space_coordinates[1]
            )
            draw.text((text_w, text_h), msg, font=opensans_font, fill=color)

        # draw vertical line in the middle or remaining space
        draw.line(
            (
                remaining_space_coordinates[0] + line_margin,
                remaining_space_coordinates[1] + remaining_space_h / 2,
                remaining_space_coordinates[2] - line_margin,
                remaining_space_coordinates[1] + remaining_space_h / 2,
            ),
            fill="#A0A0A0",
            width=2,
        )

        # draw medals
        medal_size = (20, 20)
        medal_margin = 10
        medal_w = medal_size[0] + medal_margin
        medal_h = medal_size[1] + medal_margin

        medal_w_count = int(remaining_space_w / medal_w)
        medal_h_count = int(remaining_space_h / medal_h)

        current_x = remaining_space_coordinates[0] + 2 * line_margin

        for index, medal_number in enumerate(medals[i]):
            """
            medal_image = Image.open(requests.get(medal_image_urls[index], stream=True).raw)

            medal_image = medal_image.resize(medal_size)
            medal_image_coordinates = (
                current_x,
                int(remaining_space_coordinates[1] + remaining_space_h / 2 + line_margin),
            )
            current_x += medal_w
            image.paste(medal_image, medal_image_coordinates, medal_image.convert("RGBA"))
            """
            msg = "● " + str(medal_number)
            print(msg)

            text_w = current_x
            text_h = int(
                remaining_space_coordinates[1] + remaining_space_h / 2 + line_margin / 2
            )
            medal_font = ImageFont.truetype("CascadiaCode.ttf", 20)
            draw.text((text_w, text_h), msg, font=medal_font, fill=medal_colors[index])
            current_x += remaining_space_w / 3 - line_margin

        if i != 0:
            draw.line(
                (line_margin, i * row_height, size[0] - line_margin, i * row_height),
                width=3,
                fill="#A0A0A0",
                joint="round",
            )

    return image


def main(debug=False):
    driver = get_driver()
    driver.get("http://kaggle.com/" + sys.argv[1])

    source = BeautifulSoup(driver.page_source, features="html.parser")
    results = make_dict(source)
    pprint(results)

    image = build_image(results)
    if debug:
        image.show()
    image.save("kaggle_user_data.png")


# create image

if __name__ == "__main__":
    main()
