package project.app.action;

import java.sql.SQLException;
import java.sql.SQLIntegrityConstraintViolationException;
import java.util.Map;

import org.apache.struts2.interceptor.SessionAware;

import com.opensymphony.xwork2.ActionSupport;

import project.app.model.BookCopy;
import project.app.model.BookEntry;
import project.app.service.DBService;

public class AdminAddBookCopy extends ActionSupport implements SessionAware {
    private Map<String, Object> userSession;

    private BookCopy bookCopyBean;
    private BookEntry bookEntryBean;
    private String error;
    private String validationString;

    public String execute() {
        int bookEntryId = (int) userSession.get("bookEntryId");
        try {
            bookEntryBean = DBService.getBookEntryById(bookEntryId);
            return SUCCESS;
        } catch (ClassNotFoundException | SQLException e) {
            error = e.toString();
            e.printStackTrace();
            return ERROR;
        }
    }

    public String addBookCopy() {
        bookCopyBean.setBookEntryId((int) userSession.get("bookEntryId"));
        try {
            DBService.addBookCopy(bookCopyBean);
            return SUCCESS;
        } catch (SQLException | ClassNotFoundException e) {
            if(e instanceof SQLIntegrityConstraintViolationException) {
                validationString = "Serial Id already exists in database.";
                return INPUT;
            } else {
                error = e.toString();
                e.printStackTrace();
                return ERROR;
            }
        }
    }

    public BookCopy getBookCopyBean() {
        return bookCopyBean;
    }

    public void setBookCopyBean(BookCopy bookCopyBean) {
        this.bookCopyBean = bookCopyBean;
    }

    public String getError() {
        return error;
    }

    public void setError(String error) {
        this.error = error;
    }

    public BookEntry getBookEntryBean() {
        return bookEntryBean;
    }

    public void setBookEntryBean(BookEntry bookEntryBean) {
        this.bookEntryBean = bookEntryBean;
    }

    public Map<String, Object> getUserSession() {
        return userSession;
    }

    public void setUserSession(Map<String, Object> userSession) {
        this.userSession = userSession;
    }

    public String getValidationString() {
        return validationString;
    }

    public void setValidationString(String validationString) {
        this.validationString = validationString;
    }

    @Override
    public void setSession(Map<String, Object> session) {
        userSession = session;        
    }
}
