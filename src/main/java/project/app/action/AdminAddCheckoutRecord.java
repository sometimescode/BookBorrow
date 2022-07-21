package project.app.action;

import java.sql.SQLException;
import java.util.Map;

import org.apache.struts2.interceptor.SessionAware;

import com.opensymphony.xwork2.ActionSupport;

import project.app.model.CheckoutRecord;
import project.app.service.DBService;

public class AdminAddCheckoutRecord extends ActionSupport implements SessionAware {
    private Map<String, Object> userSession;

    private String error;
    private CheckoutRecord checkoutRecordBean;

    public String addCheckoutRecord() {
        try {
            DBService.addCheckoutRecord(checkoutRecordBean);
            DBService.updateBookCopyStatusById(checkoutRecordBean.getOnlineCheckoutRequestId(), "Checked Out");
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

    public CheckoutRecord getCheckoutRecordBean() {
        return checkoutRecordBean;
    }

    public void setCheckoutRecordBean(CheckoutRecord checkoutRecordBean) {
        this.checkoutRecordBean = checkoutRecordBean;
    }

    @Override
    public void setSession(Map<String, Object> session) {
        userSession = session;
        
    }
}
