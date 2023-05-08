package com.bongsick.bongsick.respository;

import com.bongsick.bongsick.domain.Company;
import com.bongsick.bongsick.domain.Theme;

import java.util.List;

public interface Repository {
    List<Theme> getThemes();

    List<Company> getCompanies();

    Company getCompany(String companyId);

    Theme getThemeDetail(String themeId);

    List<Theme> getThemesByCompany(String companyId);
}