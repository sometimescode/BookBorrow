package project.app.action;

import java.sql.SQLException;
import java.util.Calendar;
import java.util.Date;
import java.util.Map;

import org.apache.struts2.interceptor.SessionAware;

import com.opensymphony.xwork2.ActionSupport;

import project.app.model.CheckoutRecord;
import project.app.model.OnlineCheckoutRequestInnerJoinBookEntryLeftJoinAccount;
import project.app.service.DBService;

public class AdminCheckoutRecord extends ActionSupport implements SessionAware {
    private Map<String, Object> userSession;

    private String error;
    private int checkoutRequestId;
    private CheckoutRecord checkoutRecordBean;
    private OnlineCheckoutRequestInnerJoinBookEntryLeftJoinAccount checkoutRequestBean;

    public String checkoutRecordForm() {
        try {
            OnlineCheckoutRequestInnerJoinBookEntryLeftJoinAccount checkoutRequest = DBService.getCheckoutRequestById(checkoutRequestId);
            int bookEntryId = checkoutRequest.getRequestedBookId();

            checkoutRecordBean = new CheckoutRecord();
            checkoutRecordBean.setBookEntryId(bookEntryId);
            checkoutRecordBean.setBorrowerId(checkoutRequest.getRequesterId());
            checkoutRecordBean.setOnlineCheckoutRequestId(checkoutRequest.getDbId());
            checkoutRecordBean.setBookCopyId(checkoutRequest.getRequestedCopyId());
            Calendar cal = Calendar.getInstance();
            cal.setTime( new Date() );
            cal.add( Calendar.DATE, 7 );
            checkoutRecordBean.setExpectedReturnDate(cal.getTime());
            
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

    public CheckoutRecord getCheckoutRecordBean() {
        return checkoutRecordBean;
    }

    public void setCheckoutRecordBean(CheckoutRecord checkoutRecordBean) {
        this.checkoutRecordBean = checkoutRecordBean;
    }

    public OnlineCheckoutRequestInnerJoinBookEntryLeftJoinAccount getCheckoutRequestBean() {
        return checkoutRequestBean;
    }

    public void setCheckoutRequestBean(OnlineCheckoutRequestInnerJoinBookEntryLeftJoinAccount checkoutRequestBean) {
        this.checkoutRequestBean = checkoutRequestBean;
    }

    @Override
    public void setSession(Map<String, Object> session) {
        userSession = session;
        
    }
}
