package com.bongsick.bongsick.utils;

import com.bongsick.bongsick.domain.ThemeSave;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

import java.io.IOException;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.ArrayList;
import java.util.List;

public class XPhobiaParser {
    final static String xPhobiaUrl = "https://www.xphobia.net/quest/quest_list.php";

    final private Elements quests;

    public XPhobiaParser() {
        Document doc;
        try {
            doc = Jsoup.connect(xPhobiaUrl).get();
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
        quests = doc.getElementsByClass("quest_content")
                .select(".quest_content > div");
    }

    private static ThemeSave getTheme(Element quest) {
        String detail_url = quest.select("a").first().attr("href");

        Document detail_page;
        try {
            detail_page = Jsoup.connect(detail_url).get();

        } catch (IOException e) {
            throw new RuntimeException(e);
        }

        Elements questInfo = detail_page.getElementsByClass("quest_info");


        // DTO
        ThemeSave theme = new ThemeSave();

        // name
        theme.setName(getName(questInfo));

        // difficulty
        theme.setDifficulty(getDifficulty(questInfo));

        // genre, personnel, company
        Elements questType = questInfo.select("div.quest_type > dl");
        for (Element element : questType) {

            //genre
            if (element.select("dt").text().equals("장르")) {
                String genre = element.select("dd").text();
                theme.setGenre(genre);
            }

            // personnel
            if (element.select("dt").text().equals("추천인원")) {
                String personnel = element.select("dd").text();
                int personnel_min = Integer.parseInt(personnel.substring(0, 1));
                int personnel_max = Integer.parseInt(personnel.substring(2, 3));
                theme.setPersonnelMin(personnel_min);
                theme.setPersonnelMax(personnel_max);
            }

            // company
            if (element.select("dt").text().equals("지점")) {
                ArrayList<String> companies = new ArrayList<>();
                Elements companies_span = element.select("dd > span");
                for (Element company_span : companies_span) {
                    companies.add(company_span.text());
                }
                theme.setCompanies(companies);
            }
        }


        // imgUrl
        theme.setImgUrl(getImgUrl(questInfo));


        // story
        theme.setStory(getStory(questInfo));

        // reservationUrl

        theme.setReservationUrl(getReservationUrl(questInfo));

        return theme;
    }

    private static String getStory(Elements questInfo) {
        StringBuilder stringBuilder = new StringBuilder();

        Elements stories = questInfo.select("div.txt_inner > div, div.txt_inner > p");

        for (Element story : stories) {
            stringBuilder.append(story.text());
            stringBuilder.append('\n');
        }

        if(stringBuilder.isEmpty()){
            System.out.println("stories = " + stories);
            System.out.println("questInfo = " + questInfo);
        }

        return stringBuilder.toString();
    }

    private static String getImgUrl(Elements questInfo) {

        String imgUrl = questInfo.select("div.thumbs > img").attr("src");

        String encode = URLEncoder.encode(imgUrl, StandardCharsets.UTF_8);
        encode = encode.replaceAll("%3A", ":");
        encode = encode.replaceAll("%2F", "/");

        return encode;
    }

    private static int getDifficulty(Elements questInfo) {
        String difficulty_img = questInfo.select("div.tit_block > p > img").attr("src");
        return Integer.parseInt(difficulty_img.substring(difficulty_img.length() - 5, difficulty_img.length() - 4)) * 2;
    }

    private static String getName(Elements questInfo) {
        return questInfo.select("div.tit_block > h5").text();
    }

    private static String getReservationUrl(Elements questInfo){
        return questInfo.select("div.txt_inner > a.link_more").attr("href");
    }

    public List<ThemeSave> getThemes() {
        ArrayList<ThemeSave> themes = new ArrayList<>();
        for (Element quest : quests) {
            themes.add(getTheme(quest));
        }

        return themes;
    }

}
