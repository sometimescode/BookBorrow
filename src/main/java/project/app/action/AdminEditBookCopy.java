package project.app.action;

import java.sql.SQLException;
import java.sql.SQLIntegrityConstraintViolationException;
import java.util.Map;

import org.apache.struts2.interceptor.SessionAware;

import com.opensymphony.xwork2.ActionSupport;

import project.app.model.BookCopy;
import project.app.model.BookEntry;
import project.app.service.DBService;

public class AdminEditBookCopy extends ActionSupport implements SessionAware {
    private Map<String, Object> userSession;

    private String error;
    private int id;
    private BookCopy bookCopyBean;
    private BookEntry bookEntryBean;
    private String validationString;

    public String getBookCopyById() {
        try {
            bookCopyBean = DBService.getBookCopyById(id);
            bookEntryBean = DBService.getBookEntryById(bookCopyBean.getBookEntryId());
            return SUCCESS;
        } catch (ClassNotFoundException | SQLException e) {
            error = e.toString();
            e.printStackTrace();
            return ERROR;
        }
    }

    public String editBookCopy() {
        try {
            bookCopyBean.setDbId(id);
            DBService.editBookCopy(bookCopyBean);
            return SUCCESS;
        } catch (ClassNotFoundException | SQLException e) {
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

    public String getError() {
        return error;
    }

    public void setError(String error) {
        this.error = error;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public BookCopy getBookCopyBean() {
        return bookCopyBean;
    }

    public void setBookCopyBean(BookCopy bookCopyBean) {
        this.bookCopyBean = bookCopyBean;
    }

    public BookEntry getBookEntryBean() {
        return bookEntryBean;
    }

    public void setBookEntryBean(BookEntry bookEntryBean) {
        this.bookEntryBean = bookEntryBean;
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
