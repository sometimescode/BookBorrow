package project.app.action;

import java.io.IOException;
import java.sql.SQLException;
import java.sql.SQLIntegrityConstraintViolationException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.struts2.interceptor.SessionAware;

import com.opensymphony.xwork2.ActionSupport;

import project.app.model.BookEntry;
import project.app.model.ISBNResponse;
import project.app.service.DBService;
import project.app.service.OpenLibraryAPIService;

public class AdminAddBook extends ActionSupport implements SessionAware {
    private Map<String, Object> userSession;

    private String queryISBN;
    private BookEntry bookEntryBean;
    private BookEntry openLibraryBookEntryBean;
    private ISBNResponse ISBNResponseBean;
    private String error;
    private String validationString;

    private List<String> authorList = new ArrayList<String>();
    private List<String> genreList = Arrays.asList(new String[] {"Fiction", "Non-Fiction"});

    public String execute() {
        return SUCCESS;
    }

    private void populateFieldSuggestions() {
        int authorCount;
        String[] authorNames;

        //needs to be initialized because it is not a part of the form with searchBook action
        openLibraryBookEntryBean = new BookEntry();

        openLibraryBookEntryBean.setTitle(ISBNResponseBean.getTitle());
        
        if(ISBNResponseBean.getAuthors() != null) {
            authorCount = ISBNResponseBean.getAuthors().length;
            authorNames = new String[authorCount];
            for(int x = 0; x < authorCount; x++) {
                authorNames[x] = ISBNResponseBean.getAuthors()[x].getName();
            }
            authorList = Arrays.asList(authorNames);
            openLibraryBookEntryBean.setAuthors(Arrays.toString(authorNames).replace("[", "").replace("]", ""));
        }

        openLibraryBookEntryBean.setISBN(queryISBN);
        openLibraryBookEntryBean.setPageCount(ISBNResponseBean.getNumber_of_pages());

        if(ISBNResponseBean.getPublishers() != null) {
            openLibraryBookEntryBean.setPublisher(ISBNResponseBean.getPublishers()[0].getName());
        }

        Date date;
        try {
            date = new SimpleDateFormat("MMMM d, yyyy").parse(ISBNResponseBean.getPublish_date());
        } catch (ParseException e) {
            date = null;
            e.printStackTrace();
        }
        openLibraryBookEntryBean.setPublishedDate(date);
        
        if(ISBNResponseBean.getCover() != null) {
            openLibraryBookEntryBean.setCover(ISBNResponseBean.getCover().getMedium());
        }
    }

    public String searchBookFromOpenLibrary() {
        try {
            ISBNResponseBean = OpenLibraryAPIService.searchISBNAPI(queryISBN);
            populateFieldSuggestions();
            return SUCCESS;
        } catch (IOException e) {
            e.printStackTrace();
            error = e.toString();
            return ERROR;
        }
    }

    public String copyToAddBookForm() {
        //needs to be initialized because it is not a part of the form with searchBook action
        bookEntryBean = new BookEntry();
        bookEntryBean.setTitle(openLibraryBookEntryBean.getTitle());
        bookEntryBean.setAuthors(openLibraryBookEntryBean.getAuthors());
        bookEntryBean.setISBN(openLibraryBookEntryBean.getISBN());
        bookEntryBean.setPageCount(openLibraryBookEntryBean.getPageCount());
        bookEntryBean.setPublisher(openLibraryBookEntryBean.getPublisher());
        bookEntryBean.setPublishedDate(openLibraryBookEntryBean.getPublishedDate());
        bookEntryBean.setCover(openLibraryBookEntryBean.getCover());
        return SUCCESS;
    }

    public String addBookEntry() {
        try {
            int bookEntryId = DBService.addBookEntryGetId(bookEntryBean);

            if(bookEntryId != -1) {
                userSession.put("bookEntryId", bookEntryId);
                return SUCCESS;
            } else {
                return ERROR;
            }
        } catch (SQLException | ClassNotFoundException | IOException e) {
            if(e instanceof SQLIntegrityConstraintViolationException) {
                validationString = "ISBN already exists in database.";
                return INPUT;
            } else {
                error = e.toString();
                e.printStackTrace();
                return ERROR;
            }
        }
    }

    public String getQueryISBN() {
        return queryISBN;
    }

    public void setQueryISBN(String queryISBN) {
        this.queryISBN = queryISBN;
    }

    public List<String> getAuthorList() {
        return authorList;
    }

    public void setAuthorList(List<String> authorList) {
        this.authorList = authorList;
    }

    public List<String> getGenreList() {
        return genreList;
    }

    public void setGenreList(List<String> genreList) {
        this.genreList = genreList;
    }

    public BookEntry getBookEntryBean() {
        return bookEntryBean;
    }

    public void setBookEntryBean(BookEntry bookEntryBean) {
        this.bookEntryBean = bookEntryBean;
    }

    public ISBNResponse getISBNResponseBean() {
        return ISBNResponseBean;
    }

    public void setISBNResponseBean(ISBNResponse iSBNResponseBean) {
        ISBNResponseBean = iSBNResponseBean;
    }

    public String getError() {
        return error;
    }

    public void setError(String error) {
        this.error = error;
    }

    public BookEntry getOpenLibraryBookEntryBean() {
        return openLibraryBookEntryBean;
    }

    public void setOpenLibraryBookEntryBean(BookEntry openLibraryBookEntryBean) {
        this.openLibraryBookEntryBean = openLibraryBookEntryBean;
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
