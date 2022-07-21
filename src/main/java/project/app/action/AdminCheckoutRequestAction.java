package project.app.action;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.struts2.interceptor.SessionAware;

import com.opensymphony.xwork2.ActionSupport;

import project.app.model.BookCopy;
import project.app.model.OnlineCheckoutRequestInnerJoinBookEntryLeftJoinAccount;
import project.app.service.DBService;

public class AdminCheckoutRequestAction extends ActionSupport implements SessionAware {
    private Map<String, Object> userSession;

    private String error;
    private OnlineCheckoutRequestInnerJoinBookEntryLeftJoinAccount checkoutRequestBean;
    private int checkoutRequestId;
    private List<String> bookCopySelectList;

    public String checkoutRequestForm() {
        try {
            OnlineCheckoutRequestInnerJoinBookEntryLeftJoinAccount checkoutRequest = DBService.getCheckoutRequestById(checkoutRequestId);
            int bookEntryId = checkoutRequest.getRequestedBookId();
           
            List<BookCopy> availableBookCopies = new ArrayList<BookCopy>();
            availableBookCopies = DBService.getBookCopies(bookEntryId, true);
            bookCopySelectList = new ArrayList<String>();
            for (int i = 0; i < availableBookCopies.size(); i++) {
                bookCopySelectList.add(Integer.toString(availableBookCopies.get(i).getDbId()));
            }

            return SUCCESS;
        } catch (ClassNotFoundException | SQLException e) {
            error = e.toString();
            e.printStackTrace();
            return ERROR;
        }
    }

    public String approveCheckoutRequest() {
        try {
            DBService.approveCheckoutRequest(checkoutRequestId, checkoutRequestBean.getRequestedCopyId());
            DBService.updateBookCopyStatusById(checkoutRequestBean.getRequestedCopyId(), "Pending Check Out");
            return SUCCESS;
        } catch (SQLException | ClassNotFoundException e) {
            error = e.toString();
            e.printStackTrace();
            return ERROR;
        }
    }

    public String rejectCheckoutRequest() {
        try {
            DBService.rejectCheckoutRequest(checkoutRequestId);
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

    public int getCheckoutRequestId() {
        return checkoutRequestId;
    }

    public void setCheckoutRequestId(int checkoutRequestId) {
        this.checkoutRequestId = checkoutRequestId;
    }

    public OnlineCheckoutRequestInnerJoinBookEntryLeftJoinAccount getCheckoutRequestBean() {
        return checkoutRequestBean;
    }

    public void setCheckoutRequestBean(OnlineCheckoutRequestInnerJoinBookEntryLeftJoinAccount checkoutRequestBean) {
        this.checkoutRequestBean = checkoutRequestBean;
    }

    public List<String> getBookCopySelectList() {
        return bookCopySelectList;
    }

    public void setBookCopySelectList(List<String> bookCopySelectList) {
        this.bookCopySelectList = bookCopySelectList;
    }

    @Override
    public void setSession(Map<String, Object> session) {
        userSession = session;
        
    }
}
