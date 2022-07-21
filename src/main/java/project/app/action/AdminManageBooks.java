package project.app.action;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.apache.struts2.interceptor.SessionAware;

import com.opensymphony.xwork2.ActionSupport;

import project.app.model.BookEntry;
import project.app.service.DBService;

public class AdminManageBooks extends ActionSupport implements SessionAware {
    private Map<String, Object> userSession;

    private String error;
    private List<BookEntry> allBookEntries;

    public String execute() {
        try {
            allBookEntries = DBService.getBookEntries();
            return SUCCESS;
        } catch (ClassNotFoundException | SQLException e) {
            error = e.toString();
            e.printStackTrace();
            return ERROR;
        }
    }

    public List<BookEntry> getAllBookEntries() {
        return allBookEntries;
    }

    public void setAllBookEntries(List<BookEntry> allBookEntries) {
        this.allBookEntries = allBookEntries;
    }

    public String getError() {
        return error;
    }

    public void setError(String error) {
        this.error = error;
    }

    @Override
    public void setSession(Map<String, Object> session) {
        userSession = session;
    }
}
