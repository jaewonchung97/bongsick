package com.bongsick.bongsick.service;

import com.bongsick.bongsick.domain.Company;
import com.bongsick.bongsick.domain.Theme;
import com.bongsick.bongsick.domain.ThemeSave;
import com.bongsick.bongsick.respository.Repository;
import com.bongsick.bongsick.utils.URLEncoder;
import com.bongsick.bongsick.utils.XPhobiaParser;
import com.google.cloud.firestore.GeoPoint;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Scanner;

@Service
public class CrawlingService {
    private final Repository repository;

    @Autowired
    public CrawlingService(Repository repository) {
        this.repository = repository;
    }

    public void saveXPhobiaThemes() {
        XPhobiaParser xPhobiaParser = new XPhobiaParser();
        List<ThemeSave> themes = xPhobiaParser.getThemes();
        for (ThemeSave theme : themes) {
            repository.saveTheme(theme);
        }
    }


    public Company saveCompany(String companyName) {

        // TODO -- 테마 회사 이름 변경하기 or ID로 변경

        System.out.println("============" + companyName + "============");
        String naverMapSearchUrl = "https://pcmap.place.naver.com/place/list?query=";
        Scanner scanner = new Scanner(System.in);
        List<Company> candidateCompanies = new ArrayList<>();
        try {
            URL url = new URL(URLEncoder.encode(naverMapSearchUrl + companyName));
            HttpURLConnection connection = (HttpURLConnection) url.openConnection();
            connection.setRequestMethod("GET");

            InputStream inputStream = connection.getInputStream();
            InputStreamReader inputStreamReader = new InputStreamReader(inputStream);
            BufferedReader bufferedReader = new BufferedReader(inputStreamReader);

            String inputLine;

            JSONObject jsonObject;
            while ((inputLine = bufferedReader.readLine()) != null) {
                if (inputLine.contains("window.__APOLLO_STATE__ = {\"Panorama")) {
                    int startIndex = inputLine.indexOf("window.__APOLLO_STATE__ = ") + 26;
                    String jsonText = inputLine.substring(startIndex, inputLine.length() - 1);
                    jsonObject = new JSONObject(jsonText);
                    Iterator<String> keys = jsonObject.keys();
                    while (keys.hasNext()) {
                        String key = keys.next();
                        if (key.startsWith("PlaceSummary")) {
                            JSONObject themeJson = jsonObject.getJSONObject(key);
                            String id = themeJson.getString("id");
                            String name = themeJson.getString("name");
                            String roadAddress = themeJson.getString("roadAddress");
                            String phone = null;
                            try {
                                phone = themeJson.getString("phone");
                            } catch (Exception e) {
                                try {
                                    phone = themeJson.getString("virtualPhone");
                                } catch (Exception a) {
                                    System.out.println(name+" Does Not Have Phone Number");
                                }
                            }
                            double x = themeJson.getDouble("x");
                            double y = themeJson.getDouble("y");

                            Company company = new Company();
                            company.setId(id);
                            company.setName(name);
                            company.setAddress(roadAddress);
                            company.setPhone(phone);
                            company.setLocation(new GeoPoint(y, x));

                            candidateCompanies.add(company);
                        }
                    }
                }
            }

            int index = 0;
            for (Company candidateCompany : candidateCompanies) {
                System.out.println("[" + index++ + "]" + candidateCompany);
            }
            System.out.println("SELECT> ");
            int selectIndex = Integer.parseInt(scanner.next());

            //TODO -- 검색 결과 없을때는 직접 id 집어넣어서 확인

            Company selectedCompany = candidateCompanies.get(selectIndex);
            String s = repository.saveCompany(selectedCompany);
            System.out.println(s);

            return selectedCompany;
        } catch (
                IOException e) {
            throw new RuntimeException(e);
        }
    }

}
