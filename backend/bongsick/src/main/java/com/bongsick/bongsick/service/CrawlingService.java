package com.bongsick.bongsick.service;

import com.bongsick.bongsick.domain.Theme;
import com.bongsick.bongsick.domain.ThemeSave;
import com.bongsick.bongsick.respository.Repository;
import com.bongsick.bongsick.utils.XPhobiaParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CrawlingService {
    private final Repository repository;

    @Autowired
    public CrawlingService(Repository repository) {
        this.repository = repository;
    }

    public void saveXPhobiaThemes(){
        XPhobiaParser xPhobiaParser = new XPhobiaParser();
        List<ThemeSave> themes = xPhobiaParser.getThemes();
        for (ThemeSave theme : themes) {
            repository.saveTheme(theme);
        }
    }
}
