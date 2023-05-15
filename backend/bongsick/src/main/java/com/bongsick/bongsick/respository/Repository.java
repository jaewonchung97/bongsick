package com.bongsick.bongsick.respository;

import com.bongsick.bongsick.domain.Company;
import com.bongsick.bongsick.domain.Theme;
import com.bongsick.bongsick.domain.ThemeSave;

import java.util.List;

public interface Repository {
    List<Theme> getThemes();

    List<Company> getCompanies();

    Company getCompany(String companyId);

    Theme getThemeDetail(String themeId);

    List<Theme> getThemesByCompany(String companyId);

    String saveTheme(ThemeSave theme);

    String saveCompany(Company company);

    void deleteThemes();

    List<String> getAllCompaniesName();

    void changeAllCompanyName(String companyName, String newCompanyName);
}