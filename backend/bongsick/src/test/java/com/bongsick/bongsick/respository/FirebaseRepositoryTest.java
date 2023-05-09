package com.bongsick.bongsick.respository;

import com.bongsick.bongsick.config.FirebaseConfig;
import com.bongsick.bongsick.domain.Company;
import com.bongsick.bongsick.domain.CompanySave;
import com.bongsick.bongsick.domain.Theme;
import com.bongsick.bongsick.domain.ThemeSave;
import jakarta.annotation.PostConstruct;
import org.junit.jupiter.api.Test;

import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

class FirebaseRepositoryTest {
    private final static Repository repository = new FirebaseRepository(new FirebaseConfig().firestore());


    @Test
    void saveTheme() {

    }

    @Test
    void deleteTheme() {
        repository.deleteThemes();
    }

    @Test
    void getCompanies(){
        repository.getAllCompanies();
    }

    @Test
    void saveAllCompanies(){
        List<String> companiesName = repository.getAllCompanies();
        for (String companyName : companiesName) {
            CompanySave companyDomain = new CompanySave();
            companyDomain.setName(companyName);
            repository.saveCompany(companyDomain);
        }

    }
}