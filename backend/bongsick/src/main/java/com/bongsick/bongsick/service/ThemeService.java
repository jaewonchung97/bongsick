package com.bongsick.bongsick.service;

import com.bongsick.bongsick.domain.Company;
import com.bongsick.bongsick.domain.Theme;
import com.bongsick.bongsick.respository.FirebaseRepository;
import com.bongsick.bongsick.respository.Repository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ThemeService {
    private final Repository repository;

    @Autowired
    public ThemeService(Repository repository) {
        this.repository = repository;
    }

    public List<Theme> getThemes() {
        return repository.getThemes();
    }

    public List<Company> getCompanies(){
        return repository.getCompanies();
    }

    public Company getCompany(String companyId) {
        return repository.getCompany(companyId);
    }

    public Theme getThemeDetail(String themeId) {
        return repository.getThemeDetail(themeId);
    }

    public List<Theme> getThemesByCompany(String companyId) {
        return repository.getThemesByCompany(companyId);
    }

}
