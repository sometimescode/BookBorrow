package project.app.action;

import java.sql.SQLException;
import java.util.Map;

import org.apache.struts2.interceptor.SessionAware;

import com.opensymphony.xwork2.ActionSupport;

import project.app.service.DBService;

public class AdminDeleteBook extends ActionSupport implements SessionAware {
    private Map<String, Object> userSession;

    private String error;
    private int bookEntryId;

    public String deleteBookEntry() {
        try {
            DBService.deleteBookEntry(bookEntryId);
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

    public int getBookEntryId() {
        return bookEntryId;
    }

    public void setBookEntryId(int bookEntryId) {
        this.bookEntryId = bookEntryId;
    }

    @Override
    public void setSession(Map<String, Object> session) {
        userSession = session;
    }
}
