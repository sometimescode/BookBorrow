package project.app.action;

import java.sql.SQLException;
import java.sql.SQLIntegrityConstraintViolationException;

import com.opensymphony.xwork2.ActionSupport;

import project.app.model.User;
import project.app.service.DBService;

public class Register extends ActionSupport {
    private User userBean;
    private String error;
    private String validationString;

    public String execute() {
        return SUCCESS;
    }

    public String registerUser() {
        try {
            DBService.registerUser(userBean);
            return SUCCESS;
        } catch (SQLException | ClassNotFoundException e) {
            if(e instanceof SQLIntegrityConstraintViolationException) {
                validationString = "Username already exists. Please try a different one.";
                return INPUT;
            } else {
                error = e.toString();
                e.printStackTrace();
                return ERROR;
            }
        }
    }

    public User getUserBean() {
        return userBean;
    }

    public void setUserBean(User userBean) {
        this.userBean = userBean;
    }

    public String getError() {
        return error;
    }

    public void setError(String error) {
        this.error = error;
    }

    public String getValidationString() {
        return validationString;
    }

    public void setValidationString(String validationString) {
        this.validationString = validationString;
    }
}
