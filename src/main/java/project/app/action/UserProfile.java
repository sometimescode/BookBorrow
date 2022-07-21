package project.app.action;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.struts2.interceptor.SessionAware;

import com.opensymphony.xwork2.ActionSupport;

import project.app.model.CheckoutRecordInnerJoinBookEntryLeftJoinAccount;
import project.app.model.OnlineCheckoutRequestInnerJoinBookEntryLeftJoinAccount;
import project.app.service.DBService;

public class UserProfile extends ActionSupport implements SessionAware {
    private Map<String, Object> userSession;

    private String error;
    private List<CheckoutRecordInnerJoinBookEntryLeftJoinAccount> checkedOutBooks;
    private List<OnlineCheckoutRequestInnerJoinBookEntryLeftJoinAccount> pendingCheckoutRequests;
    private List<OnlineCheckoutRequestInnerJoinBookEntryLeftJoinAccount> approvedCheckoutRequests;
    private List<OnlineCheckoutRequestInnerJoinBookEntryLeftJoinAccount> onlineCheckoutRequests;
    private List<CheckoutRecordInnerJoinBookEntryLeftJoinAccount> allCheckoutRecords;
    private int checkoutRequestId;
    private int bookCopyId;
 
    public String execute() {
        int userId = (int) userSession.get("id");
        try {
            checkedOutBooks = DBService.getCheckedOutBooksByUser(userId);
            pendingCheckoutRequests = DBService.getPendingCheckoutRequestsByUser(userId);
            approvedCheckoutRequests = DBService.getApprovedCheckoutRequestsByUser(userId);
            onlineCheckoutRequests = DBService.getCheckoutRequestsByUser(userId);
            allCheckoutRecords = DBService.getCheckoutRecordsByUser(userId);
            return SUCCESS;
        } catch (SQLException | ClassNotFoundException e) {
            error = e.toString();
            e.printStackTrace();
            return ERROR;
        }
    }
    
    public String cancelPendingCheckoutRequest() {
        try {
            DBService.cancelCheckoutRequest(checkoutRequestId);
            return SUCCESS;
        } catch (SQLException | ClassNotFoundException e) {
            error = e.toString();
            e.printStackTrace();
            return ERROR;
        }
    }

    public String cancelApprovedCheckoutRequest() {
        try {
            DBService.cancelCheckoutRequest(checkoutRequestId);
            DBService.checkinBookCopy(bookCopyId);
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

    public List<CheckoutRecordInnerJoinBookEntryLeftJoinAccount> getCheckedOutBooks() {
        return checkedOutBooks;
    }

    public void setCheckedOutBooks(List<CheckoutRecordInnerJoinBookEntryLeftJoinAccount> checkedOutBooks) {
        this.checkedOutBooks = checkedOutBooks;
    }

    public List<OnlineCheckoutRequestInnerJoinBookEntryLeftJoinAccount> getPendingCheckoutRequests() {
        return pendingCheckoutRequests;
    }

    public void setPendingCheckoutRequests(
            List<OnlineCheckoutRequestInnerJoinBookEntryLeftJoinAccount> pendingCheckoutRequests) {
        this.pendingCheckoutRequests = pendingCheckoutRequests;
    }

    public List<OnlineCheckoutRequestInnerJoinBookEntryLeftJoinAccount> getOnlineCheckoutRequests() {
        return onlineCheckoutRequests;
    }

    public void setOnlineCheckoutRequests(List<OnlineCheckoutRequestInnerJoinBookEntryLeftJoinAccount> onlineCheckoutRequests) {
        this.onlineCheckoutRequests = onlineCheckoutRequests;
    }

    public int getCheckoutRequestId() {
        return checkoutRequestId;
    }

    public void setCheckoutRequestId(int checkoutRequestId) {
        this.checkoutRequestId = checkoutRequestId;
    }

    public List<CheckoutRecordInnerJoinBookEntryLeftJoinAccount> getAllCheckoutRecords() {
        return allCheckoutRecords;
    }

    public void setAllCheckoutRecords(List<CheckoutRecordInnerJoinBookEntryLeftJoinAccount> allCheckoutRecords) {
        this.allCheckoutRecords = allCheckoutRecords;
    }

    public List<OnlineCheckoutRequestInnerJoinBookEntryLeftJoinAccount> getApprovedCheckoutRequests() {
        return approvedCheckoutRequests;
    }

    public void setApprovedCheckoutRequests(
            List<OnlineCheckoutRequestInnerJoinBookEntryLeftJoinAccount> approvedCheckoutRequests) {
        this.approvedCheckoutRequests = approvedCheckoutRequests;
    }

    public int getBookCopyId() {
        return bookCopyId;
    }

    public void setBookCopyId(int bookCopyId) {
        this.bookCopyId = bookCopyId;
    }

    @Override
    public void setSession(Map<String, Object> session) {
        userSession = session;
        
    }
}
