package project.app.action;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.struts2.interceptor.SessionAware;

import com.opensymphony.xwork2.ActionSupport;

import project.app.model.CheckoutRecordInnerJoinBookEntryLeftJoinAccount;
import project.app.model.OnlineCheckoutRequestInnerJoinBookEntryLeftJoinAccount;
import project.app.service.DBService;

public class AdminPanel extends ActionSupport implements SessionAware {
    private Map<String, Object> userSession;

    private String error;
    private List<OnlineCheckoutRequestInnerJoinBookEntryLeftJoinAccount> pendingCheckoutRequests;
    private List<CheckoutRecordInnerJoinBookEntryLeftJoinAccount> expectedCheckins;
    
    public String execute() {
        try {
            pendingCheckoutRequests = DBService.getPendingCheckoutRequests();
            expectedCheckins = DBService.getExpectedCheckins();
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

    public List<OnlineCheckoutRequestInnerJoinBookEntryLeftJoinAccount> getPendingCheckoutRequests() {
        return pendingCheckoutRequests;
    }

    public void setPendingCheckoutRequests(
            List<OnlineCheckoutRequestInnerJoinBookEntryLeftJoinAccount> pendingCheckoutRequests) {
        this.pendingCheckoutRequests = pendingCheckoutRequests;
    }

    public List<CheckoutRecordInnerJoinBookEntryLeftJoinAccount> getExpectedCheckins() {
        return expectedCheckins;
    }

    public void setExpectedCheckins(List<CheckoutRecordInnerJoinBookEntryLeftJoinAccount> expectedCheckins) {
        this.expectedCheckins = expectedCheckins;
    }

    @Override
    public void setSession(Map<String, Object> session) {
        userSession = session;
    }
}
