package project.app.action;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.struts2.interceptor.SessionAware;

import com.opensymphony.xwork2.ActionSupport;

import project.app.model.OnlineCheckoutRequestInnerJoinBookEntryLeftJoinAccount;
import project.app.service.DBService;

public class AdminManageCheckoutRequests extends ActionSupport implements SessionAware {
    private Map<String, Object> userSession;

    private String error;
    private List<OnlineCheckoutRequestInnerJoinBookEntryLeftJoinAccount> pendingCheckoutRequests;
    private List<OnlineCheckoutRequestInnerJoinBookEntryLeftJoinAccount> approvedCheckoutRequests;
    private List<OnlineCheckoutRequestInnerJoinBookEntryLeftJoinAccount> allCheckoutRequests;

    public String execute() {
        try {
            pendingCheckoutRequests = DBService.getPendingCheckoutRequests();
            approvedCheckoutRequests = DBService.getApprovedCheckoutRequests();
            allCheckoutRequests = DBService.getCheckoutRequests();
            return SUCCESS;
        } catch (SQLException | ClassNotFoundException e) {
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

    public void setPendingCheckoutRequests(List<OnlineCheckoutRequestInnerJoinBookEntryLeftJoinAccount> pendingCheckoutRequests) {
        this.pendingCheckoutRequests = pendingCheckoutRequests;
    }

    public List<OnlineCheckoutRequestInnerJoinBookEntryLeftJoinAccount> getAllCheckoutRequests() {
        return allCheckoutRequests;
    }

    public void setAllCheckoutRequests(List<OnlineCheckoutRequestInnerJoinBookEntryLeftJoinAccount> allCheckoutRequests) {
        this.allCheckoutRequests = allCheckoutRequests;
    }

    public List<OnlineCheckoutRequestInnerJoinBookEntryLeftJoinAccount> getApprovedCheckoutRequests() {
        return approvedCheckoutRequests;
    }

    public void setApprovedCheckoutRequests(
            List<OnlineCheckoutRequestInnerJoinBookEntryLeftJoinAccount> approvedCheckoutRequests) {
        this.approvedCheckoutRequests = approvedCheckoutRequests;
    }

    @Override
    public void setSession(Map<String, Object> session) {
        userSession = session;
        
    }
}
