package test;

import model.Account;
import model.dao.AccountDAO;

public class TestLogin {

    public static void main(String[] args) {

    AccountDAO dao = new AccountDAO();

    Account acc = dao.login("manager", "123");

    if (acc == null) {

        System.out.println("Login FAILED");

    } else {

        System.out.println("Login SUCCESS");

    }

}

    }

