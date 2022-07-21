package project.app.action;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.struts2.interceptor.SessionAware;

import com.opensymphony.xwork2.ActionSupport;

import project.app.model.CheckoutRecordInnerJoinBookEntryLeftJoinAccount;
import project.app.service.DBService;

public class AdminManageCheckoutRecords extends ActionSupport implements SessionAware {
    private Map<String, Object> userSession;
    
    private String error;

    private List<CheckoutRecordInnerJoinBookEntryLeftJoinAccount> expectedCheckins;
    private List<CheckoutRecordInnerJoinBookEntryLeftJoinAccount> laterExpectedCheckins;
    private List<CheckoutRecordInnerJoinBookEntryLeftJoinAccount> allCheckoutRecords;

    public String execute() {
        try {
            expectedCheckins = DBService.getExpectedCheckins();
            laterExpectedCheckins = DBService.getLaterExpectedCheckins();
            allCheckoutRecords = DBService.getCheckoutRecords();
            return SUCCESS;
        } catch (ClassNotFoundException | SQLException e) {
            error = e.toString();
            e.printStackTrace();
            return ERROR;
        }
    }
    
    public String getError() {
        return error;
    }

    public void setError(String error) {
        this.error = error;
    }

    public List<CheckoutRecordInnerJoinBookEntryLeftJoinAccount> getExpectedCheckins() {
        return expectedCheckins;
    }

    public void setExpectedCheckins(List<CheckoutRecordInnerJoinBookEntryLeftJoinAccount> expectedCheckins) {
        this.expectedCheckins = expectedCheckins;
    }

    public List<CheckoutRecordInnerJoinBookEntryLeftJoinAccount> getAllCheckoutRecords() {
        return allCheckoutRecords;
    }

    public void setAllCheckoutRecords(List<CheckoutRecordInnerJoinBookEntryLeftJoinAccount> allCheckoutRecords) {
        this.allCheckoutRecords = allCheckoutRecords;
    }

    public List<CheckoutRecordInnerJoinBookEntryLeftJoinAccount> getLaterExpectedCheckins() {
        return laterExpectedCheckins;
    }

    public void setLaterExpectedCheckins(List<CheckoutRecordInnerJoinBookEntryLeftJoinAccount> laterExpectedCheckins) {
        this.laterExpectedCheckins = laterExpectedCheckins;
    }

    @Override
    public void setSession(Map<String, Object> session) {
        userSession = session;
    } 
}
