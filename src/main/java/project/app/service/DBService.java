package project.app.service;

import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.net.URL;
import java.sql.Blob;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Base64;
import java.util.Date;
import java.util.List;

import javax.imageio.ImageIO;

import project.app.model.Account;
import project.app.model.BookCopy;
import project.app.model.BookEntry;
import project.app.model.CheckoutRecord;
import project.app.model.CheckoutRecordInnerJoinBookEntryLeftJoinAccount;
import project.app.model.OnlineCheckoutRequestInnerJoinBookEntryLeftJoinAccount;
import project.app.model.User;
import project.app.model.UserSession;

public class DBService {

    private static Connection connectToDB() throws ClassNotFoundException, SQLException {
        Connection connection;
        String URL = "jdbc:mysql://localhost:3306/appdb?useTimezone=true&serverTimezone=UTC";
        Class.forName("com.mysql.jdbc.Driver");
        connection = DriverManager.getConnection(URL, "root", "password");

        return connection;
    }

    public static void registerUser(User user) throws SQLException, ClassNotFoundException {
        Connection connection = null;
        Statement statement = null;

        try {
            connection = connectToDB();

            statement = connection.createStatement();
            String sql = "INSERT INTO accounts(username, password, first_name, last_name, email, contact_number)\n" +
                "VALUES('"+user.getUsername()+"','"+
                user.getPassword()+"','"+
                user.getFirstName()+"','"+
                user.getLastName()+"','"+
                user.getEmail()+"','"+
                user.getContactNumber()+"')";
            statement.executeUpdate(sql);
         } finally {
            if (statement != null) try { statement.close(); } catch (SQLException ignore) {}
            if (connection != null) try { connection.close(); } catch (SQLException ignore) {}
         }
    }

    public static UserSession verifyCredentials(Account account) throws SQLException, ClassNotFoundException  {
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        UserSession userSessionData = null;

        try {
            connection = connectToDB();

            String sql = "SELECT id, first_name, role FROM accounts\n" + 
                "WHERE username = '" + account.getUsername() + "'\n" +
                "AND password = '" + account.getPassword() + "'";
            preparedStatement = connection.prepareStatement(sql);
            ResultSet rs = preparedStatement.executeQuery();
            
            
            while(rs.next()){  
                userSessionData = new UserSession();
                userSessionData.setId(rs.getInt(1)); 
                userSessionData.setFirstName(rs.getString(2));
                userSessionData.setRole(rs.getString(3));
            }

            return userSessionData;
         } finally {
            if (preparedStatement != null) try { preparedStatement.close(); } catch (SQLException ignore) {}
            if (connection != null) try { connection.close(); } catch (SQLException ignore) {}
         }
    }

    // String sql = "SELECT ocr.id, ocr.requester_id, ocr.requested_book_id, ocr.status, ocr.request_date, ocr.status_update_date, ocr.requested_copy_id, bc.serial_id, cr.id, be.isbn, be.title, ac.first_name, ac.last_name\n" + 
    // "FROM online_checkout_requests ocr\n" + 
    // "INNER JOIN book_entries be\n" + 
    // "ON ocr.requested_book_id = be.id\n" + 
    // "LEFT JOIN accounts ac\n" + 
    // "ON ocr.requester_id = ac.id\n" +
    // "LEFT JOIN checkout_records cr\n" + 
    // "ON ocr.id = cr.online_checkout_request_id\n" +
    // "LEFT JOIN book_copies bc\n" + 
    // "ON ocr.requested_copy_id = bc.id\n" +
    // "WHERE ocr.status = 'Pending'\n" +
    // "ORDER BY ocr.id DESC";

    // OnlineCheckoutRequestInnerJoinBookEntryLeftJoinAccount oCheckoutRequest = new OnlineCheckoutRequestInnerJoinBookEntryLeftJoinAccount();
    // oCheckoutRequest.setDbId(rs.getInt(1));
    // oCheckoutRequest.setRequesterId(rs.getInt(2));
    // oCheckoutRequest.setRequestedBookId(rs.getInt(3));
    // oCheckoutRequest.setStatus(rs.getString(4));
    // oCheckoutRequest.setRequestDate(rs.getDate(5)); 
    // oCheckoutRequest.setStatusUpdateDate(rs.getDate(6));
    // oCheckoutRequest.setCheckoutRecordId(rs.getInt(7));
    // oCheckoutRequest.setJoinBookEntryISBN(rs.getString(8));
    // oCheckoutRequest.setJoinBookEntryTitle(rs.getString(9));
    // oCheckoutRequest.setJoinAccountFirstName(rs.getString(10));
    // oCheckoutRequest.setJoinAccountLastName(rs.getString(11));

    //admin
    public static List<OnlineCheckoutRequestInnerJoinBookEntryLeftJoinAccount> getPendingCheckoutRequests() throws SQLException, ClassNotFoundException {
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        List<OnlineCheckoutRequestInnerJoinBookEntryLeftJoinAccount> oCheckoutRequests = new ArrayList<OnlineCheckoutRequestInnerJoinBookEntryLeftJoinAccount>();

        try {
            connection = connectToDB();

            String sql = "SELECT ocr.id, ocr.requester_id, ocr.requested_book_id, ocr.status, ocr.request_date, be.isbn, be.title, ac.first_name, ac.last_name\n" + 
                "FROM online_checkout_requests ocr\n" + 
                "INNER JOIN book_entries be\n" + 
                "ON ocr.requested_book_id = be.id\n" + 
                "LEFT JOIN accounts ac\n" + 
                "ON ocr.requester_id = ac.id\n" +
                "WHERE ocr.status = 'Pending'\n" +
                "ORDER BY ocr.id DESC";

            preparedStatement = connection.prepareStatement(sql);
            ResultSet rs = preparedStatement.executeQuery();

            while(rs.next()){  
                OnlineCheckoutRequestInnerJoinBookEntryLeftJoinAccount oCheckoutRequest = new OnlineCheckoutRequestInnerJoinBookEntryLeftJoinAccount();
                oCheckoutRequest.setDbId(rs.getInt(1));
                oCheckoutRequest.setRequesterId(rs.getInt(2));
                oCheckoutRequest.setRequestedBookId(rs.getInt(3));
                oCheckoutRequest.setStatus(rs.getString(4));
                oCheckoutRequest.setRequestDate(rs.getDate(5)); 
                oCheckoutRequest.setJoinBookEntryISBN(rs.getString(6));
                oCheckoutRequest.setJoinBookEntryTitle(rs.getString(7));
                oCheckoutRequest.setJoinAccountFirstName(rs.getString(8));
                oCheckoutRequest.setJoinAccountLastName(rs.getString(9));

                oCheckoutRequests.add(oCheckoutRequest);
            }

            return oCheckoutRequests;
            } finally {
            if (preparedStatement != null) try { preparedStatement.close(); } catch (SQLException ignore) {}
            if (connection != null) try { connection.close(); } catch (SQLException ignore) {}
            }
    }
    
    public static List<CheckoutRecordInnerJoinBookEntryLeftJoinAccount> getExpectedCheckins() throws SQLException, ClassNotFoundException {
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        List<CheckoutRecordInnerJoinBookEntryLeftJoinAccount> checkoutRecords = new ArrayList<CheckoutRecordInnerJoinBookEntryLeftJoinAccount>();

        try {
            connection = connectToDB();

            String sql = "SELECT cr.id, cr.book_entry_id, cr.book_copy_id, cr.borrower_id, cr.checkout_date, cr.expected_return_date, be.isbn, be.title, ac.first_name, ac.last_name\n" + 
            "FROM checkout_records cr\n" + 
            "INNER JOIN book_entries be\n" + 
            "ON cr.book_entry_id = be.id\n" + 
            "LEFT JOIN accounts ac\n" + 
            "ON cr.borrower_id = ac.id\n" + 
            "WHERE cr.expected_return_date <= CURDATE()\n" +
            "AND cr.status = 'Checked Out'";

            preparedStatement = connection.prepareStatement(sql);

            ResultSet rs = preparedStatement.executeQuery();
            
            while(rs.next()){  
                CheckoutRecordInnerJoinBookEntryLeftJoinAccount checkoutRecord = new CheckoutRecordInnerJoinBookEntryLeftJoinAccount();
                checkoutRecord.setDbId(rs.getInt(1));
                checkoutRecord.setBookEntryId(2);
                checkoutRecord.setBookCopyId(rs.getInt(3));
                checkoutRecord.setBorrowerId(rs.getInt(4));
                checkoutRecord.setCheckoutDate(rs.getDate(5));
                checkoutRecord.setExpectedReturnDate(rs.getDate(6));
                checkoutRecord.setJoinBookEntryISBN(rs.getString(7));
                checkoutRecord.setJoinBookEntryTitle(rs.getString(8));
                checkoutRecord.setJoinAccountFirstName(rs.getString(9));
                checkoutRecord.setJoinAccountLastName(rs.getString(10));

                checkoutRecords.add(checkoutRecord);
            }

            return checkoutRecords;
         } finally {
            if (preparedStatement != null) try { preparedStatement.close(); } catch (SQLException ignore) {}
            if (connection != null) try { connection.close(); } catch (SQLException ignore) {}
         }
    }

    public static List<BookEntry> getBookEntries() throws SQLException, ClassNotFoundException {
        Connection connection = null;
        PreparedStatement preparedStatement = null;
   
        List<BookEntry> bookEntries = new ArrayList<BookEntry>();

        try {
            connection = connectToDB();


            String sql = "SELECT id, ISBN, title, authors, page_count, publisher, published_date, genre \n" +
                "FROM book_entries\n" +
                "ORDER BY id DESC";

            preparedStatement = connection.prepareStatement(sql);
            ResultSet rs = preparedStatement.executeQuery();
                            
            while(rs.next()){  
                BookEntry bookEntry = new BookEntry();
                bookEntry.setDbId(rs.getInt(1));
                bookEntry.setISBN(rs.getString(2));
                bookEntry.setTitle(rs.getString(3));
                bookEntry.setAuthors(rs.getString(4));
                bookEntry.setPageCount(rs.getInt(5));
                bookEntry.setPublisher(rs.getString(6));
                bookEntry.setPublishedDate(rs.getDate(7));
                bookEntry.setGenre(rs.getString(8));

                bookEntries.add(bookEntry);
            }

            return bookEntries;
         } finally {
            if (preparedStatement != null) try { preparedStatement.close(); } catch (SQLException ignore) {}
            if (connection != null) try { connection.close(); } catch (SQLException ignore) {}
         }
    }

    public static int addBookEntryGetId(BookEntry bookEntry) throws SQLException, ClassNotFoundException, IOException {
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        ByteArrayOutputStream baos = null;

        int bookEntryId = -1;

        try {
            connection = connectToDB();

            URL url = new URL(bookEntry.getCover());
            BufferedImage image = ImageIO.read(url);
            baos = new ByteArrayOutputStream(64000);
            ImageIO.write(image, "jpg", baos);
            byte[] data = baos.toByteArray();

            String sql = "INSERT INTO book_entries(title, authors, cover, isbn, page_count, publisher, published_date, genre)\n" +
                "VALUES(?, ?, ?, ?, ?, ?, ?, ?)";

            preparedStatement = connection.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS);
            preparedStatement.setString(1, bookEntry.getTitle());                    
            preparedStatement.setString(2, bookEntry.getAuthors());
            preparedStatement.setBinaryStream(3, new ByteArrayInputStream(data), (int) data.length);
            preparedStatement.setString(4, bookEntry.getISBN());
            preparedStatement.setInt(5, bookEntry.getPageCount());
            preparedStatement.setString(6, bookEntry.getPublisher());
            preparedStatement.setDate(7, new java.sql.Date(bookEntry.getPublishedDate().getTime()));
            preparedStatement.setString(8, bookEntry.getGenre());
            preparedStatement.executeUpdate();

            ResultSet rs = preparedStatement.getGeneratedKeys();
            if(rs.next()){
                bookEntryId = rs.getInt(1);
            }

            return bookEntryId; 
         } finally {
            if (preparedStatement != null) try { preparedStatement.close(); } catch (SQLException ignore) {}
            if (connection != null) try { connection.close(); } catch (SQLException ignore) {}
            if (baos != null) try { baos.close(); } catch (IOException ignore) {}
         }
    }

    public static BookEntry getBookEntryById(int id) throws SQLException, ClassNotFoundException {
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        BookEntry bookEntry = null;
        Blob blobCover = null;
        byte[] byteCover = null;

        try {
            connection = connectToDB();

            String sql = "SELECT id, title, authors, cover, isbn, page_count, publisher, published_date, genre\n" +
                "FROM book_entries\n" +
                "WHERE id = ?";

            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setInt(1, id);
            ResultSet rs = preparedStatement.executeQuery();
            
            while(rs.next()){  
                bookEntry = new BookEntry();
                bookEntry.setDbId(rs.getInt(1));
                bookEntry.setTitle(rs.getString(2));
                bookEntry.setAuthors(rs.getString(3)); 
                
                blobCover = rs.getBlob(4);
                byteCover = blobCover.getBytes(1l, (int)blobCover.length());
                bookEntry.setCover(new String(Base64.getEncoder().encode(byteCover)));

                bookEntry.setISBN(rs.getString(5));
                bookEntry.setPageCount(rs.getInt(6));
                bookEntry.setPublisher(rs.getString(7));
                bookEntry.setPublishedDate(rs.getDate(8));
                bookEntry.setGenre(rs.getString(9));
            }

            return bookEntry;
         } finally {
            if (preparedStatement != null) try { preparedStatement.close(); } catch (SQLException ignore) {}
            if (connection != null) try { connection.close(); } catch (SQLException ignore) {}
         }
    }

    public static List<BookCopy> getBookCopies(int bookEntryId, boolean onlyAvailableCopies) throws SQLException, ClassNotFoundException {
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        List<BookCopy> bookCopies = new ArrayList<BookCopy>();

        try {
            connection = connectToDB();

            String sql = "SELECT id, serial_id, status, purchase_price\n" +
                "FROM book_copies\n" +
                "WHERE book_entry_id = ?";
            
            if(onlyAvailableCopies) {
                sql += " AND status = 'Available'";
            }
            
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setInt(1, bookEntryId);

            ResultSet rs = preparedStatement.executeQuery();
                            
            while(rs.next()){  
                BookCopy bookCopy = new BookCopy();
                bookCopy.setDbId(rs.getInt(1));
                bookCopy.setSerialId(rs.getString(2));
                bookCopy.setStatus(rs.getString(3));
                bookCopy.setPurchasePrice(rs.getInt(4));
                bookCopies.add(bookCopy);
            }

            return bookCopies;
         } finally {
            if (preparedStatement != null) try { preparedStatement.close(); } catch (SQLException ignore) {}
            if (connection != null) try { connection.close(); } catch (SQLException ignore) {}
         }
    }

    public static int getAvailableCopiesCount(int bookEntryId) throws SQLException, ClassNotFoundException {
        Connection connection = null;
        Statement statement = null;
        int recordCount = 0;

        try {
            connection = connectToDB();

            statement = connection.createStatement();
            String sql = "SELECT COUNT(*) AS recordCount\n" + 
                "FROM book_copies\n" + 
                "WHERE book_entry_id = '" + bookEntryId + "' " +
                "AND status = 'Available'";

            ResultSet rs = statement.executeQuery(sql);

            rs.next();
            recordCount = rs.getInt("recordCount");

            return recordCount;
         } finally {
            if (statement != null) try { statement.close(); } catch (SQLException ignore) {}
            if (connection != null) try { connection.close(); } catch (SQLException ignore) {}
         }
    }

    public static void deleteBookEntry(int id) throws SQLException, ClassNotFoundException {
        Connection connection = null;
        Statement statement = null;

        try {
            connection = connectToDB();
            statement = connection.createStatement();

            String sql = "DELETE FROM book_entries\n" + 
                "WHERE (id = '" + id + "')";

            statement.executeUpdate(sql);
         } finally {
            if (statement != null) try { statement.close(); } catch (SQLException ignore) {}
            if (connection != null) try { connection.close(); } catch (SQLException ignore) {}
         }
    }

    public static BookEntry getBookEntryByISBN(String ISBN) throws SQLException, ClassNotFoundException {
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        BookEntry bookEntry = null;
        Blob blobCover = null;
        byte[] byteCover = null;

        try {
            connection = connectToDB();

            String sql = "SELECT id, title, authors, cover, isbn, page_count, publisher, published_date, genre\n" +
                "FROM book_entries\n" +
                "WHERE isbn = ?";

            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, ISBN);
            ResultSet rs = preparedStatement.executeQuery();
            
            while(rs.next()){  
                bookEntry = new BookEntry();
                bookEntry.setDbId(rs.getInt(1));
                bookEntry.setTitle(rs.getString(2));
                bookEntry.setAuthors(rs.getString(3)); 
                
                blobCover = rs.getBlob(4);
                byteCover = blobCover.getBytes(1l, (int)blobCover.length());
                bookEntry.setCover(new String(Base64.getEncoder().encode(byteCover)));

                bookEntry.setISBN(rs.getString(5));
                bookEntry.setPageCount(rs.getInt(6));
                bookEntry.setPublisher(rs.getString(7));
                bookEntry.setPublishedDate(rs.getDate(8));
                bookEntry.setGenre(rs.getString(9));
            }

            return bookEntry;
         } finally {
            if (preparedStatement != null) try { preparedStatement.close(); } catch (SQLException ignore) {}
            if (connection != null) try { connection.close(); } catch (SQLException ignore) {}
         }
    }

    public static void editBookEntry(BookEntry bookEntry) throws SQLException, ClassNotFoundException {
        Connection connection = null;
        Statement statement = null;

        try {
            connection = connectToDB();

            statement = connection.createStatement();
            String sql = "UPDATE book_entries\n" + 
                "SET title = " + "'" + bookEntry.getTitle() + "'," +
                "authors = " + "'" + bookEntry.getAuthors() + "'," +
                "page_count = " + "'" + bookEntry.getPageCount() + "'," +
                "publisher = " + "'" + bookEntry.getPublisher() + "'," +
                "published_date = " + "'" + new java.sql.Date(bookEntry.getPublishedDate().getTime()) + "'," +
                "genre = " + "'" + bookEntry.getGenre() + "'\n" +
                "WHERE ( id = '" + bookEntry.getDbId() +"')";

            statement.executeUpdate(sql);
         } finally {
            if (statement != null) try { statement.close(); } catch (SQLException ignore) {}
            if (connection != null) try { connection.close(); } catch (SQLException ignore) {}
         }
    }

    public static void addBookCopy(BookCopy bookCopy) throws SQLException, ClassNotFoundException {
        Connection connection = null;
        Statement statement = null;

        try {
            connection = connectToDB();

            statement = connection.createStatement();
            String sql = "INSERT INTO book_copies(book_entry_id, serial_id, purchase_price)\n" +
                "VALUES('"+
                bookCopy.getBookEntryId()+"','"+
                bookCopy.getSerialId()+"','"+
                bookCopy.getPurchasePrice()+"')";
            statement.executeUpdate(sql);
         } finally {
            if (statement != null) try { statement.close(); } catch (SQLException ignore) {}
            if (connection != null) try { connection.close(); } catch (SQLException ignore) {}
         }
    }

    public static void deleteBookCopy(int id) throws SQLException, ClassNotFoundException {
        Connection connection = null;
        Statement statement = null;

        try {
            connection = connectToDB();

            statement = connection.createStatement();
            String sql = "DELETE FROM book_copies\n" + 
            "WHERE (id = '" + id + "')";
            
            statement.executeUpdate(sql);
         } finally {
            if (statement != null) try { statement.close(); } catch (SQLException ignore) {}
            if (connection != null) try { connection.close(); } catch (SQLException ignore) {}
         }
    }

    public static BookCopy getBookCopyById(int id) throws SQLException, ClassNotFoundException {
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        BookCopy bookCopy = null;

        try {
            connection = connectToDB();

            String sql = "SELECT id, book_entry_id, serial_id, status, purchase_price\n" +
                "FROM book_copies\n" +
                "WHERE id = ?";
            
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setInt(1, id);

            ResultSet rs = preparedStatement.executeQuery();
                            
            while(rs.next()){  
                bookCopy = new BookCopy();
                bookCopy.setDbId(rs.getInt(1));
                bookCopy.setBookEntryId(rs.getInt(2));
                bookCopy.setSerialId(rs.getString(3));
                bookCopy.setStatus(rs.getString(4));
                bookCopy.setPurchasePrice(rs.getInt(5));
            }

            return bookCopy;
         } finally {
            if (preparedStatement != null) try { preparedStatement.close(); } catch (SQLException ignore) {}
            if (connection != null) try { connection.close(); } catch (SQLException ignore) {}
         }
    }

    public static void editBookCopy(BookCopy bookCopy) throws SQLException, ClassNotFoundException {
        Connection connection = null;
        Statement statement = null;

        try {
            connection = connectToDB();

            statement = connection.createStatement();
            String sql = "UPDATE book_copies\n" + 
                "SET serial_id = " + "'" + bookCopy.getSerialId() + "', " + 
                "purchase_price = " + "'" + bookCopy.getPurchasePrice() + "'\n" +
                "WHERE ( id = '" + bookCopy.getDbId() +"')";

            statement.executeUpdate(sql);
         } finally {
            if (statement != null) try { statement.close(); } catch (SQLException ignore) {}
            if (connection != null) try { connection.close(); } catch (SQLException ignore) {}
         }
    }

    public static List<BookEntry> searchBookEntriesByTitle(String titleQuery) throws SQLException, ClassNotFoundException {
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        Blob blobCover = null;
        byte[] byteCover = null;
        List<BookEntry> bookEntries = new ArrayList<BookEntry>();

        try {
            connection = connectToDB();

            String sql = "SELECT ISBN, title, authors, cover\n" +
                "FROM book_entries\n" +
                "WHERE title LIKE '%" + titleQuery + "%'";

            preparedStatement = connection.prepareStatement(sql);
            ResultSet rs = preparedStatement.executeQuery();
                            
            while(rs.next()){  
                BookEntry bookEntry = new BookEntry();
                bookEntry.setISBN(rs.getString(1));
                bookEntry.setTitle(rs.getString(2));
                bookEntry.setAuthors(rs.getString(3));

                blobCover = rs.getBlob(4);
                byteCover = blobCover.getBytes(1l, (int)blobCover.length());
                bookEntry.setCover(new String(Base64.getEncoder().encode(byteCover)));

                bookEntries.add(bookEntry);
            }

            return bookEntries; 
         } finally {
            if (preparedStatement != null) try { preparedStatement.close(); } catch (SQLException ignore) {}
            if (connection != null) try { connection.close(); } catch (SQLException ignore) {}
         }
    }

    public static List<OnlineCheckoutRequestInnerJoinBookEntryLeftJoinAccount> getApprovedCheckoutRequests() throws SQLException, ClassNotFoundException {
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        List<OnlineCheckoutRequestInnerJoinBookEntryLeftJoinAccount> oCheckoutRequests = new ArrayList<OnlineCheckoutRequestInnerJoinBookEntryLeftJoinAccount>();

        try {
            connection = connectToDB();

            String sql = "SELECT ocr.id, ocr.requester_id, ocr.requested_book_id, ocr.status, ocr.status_update_date, bc.serial_id, be.isbn, be.title, ac.first_name, ac.last_name\n" + 
                "FROM online_checkout_requests ocr\n" + 
                "INNER JOIN book_entries be\n" + 
                "ON ocr.requested_book_id = be.id\n" + 
                "LEFT JOIN accounts ac\n" + 
                "ON ocr.requester_id = ac.id\n" +
                "LEFT JOIN book_copies bc\n" + 
                "ON ocr.requested_copy_id = bc.id\n" +
                "LEFT JOIN checkout_records cr\n" + 
                "ON ocr.id = cr.online_checkout_request_id\n" +
                "WHERE ocr.status = 'Approved'\n" +
                "AND cr.online_checkout_request_id is NULL\n" + 
                "ORDER BY ocr.id DESC";
 
            preparedStatement = connection.prepareStatement(sql);
            ResultSet rs = preparedStatement.executeQuery();

            while(rs.next()){  
                OnlineCheckoutRequestInnerJoinBookEntryLeftJoinAccount oCheckoutRequest = new OnlineCheckoutRequestInnerJoinBookEntryLeftJoinAccount();
                oCheckoutRequest.setDbId(rs.getInt(1));
                oCheckoutRequest.setRequesterId(rs.getInt(2));
                oCheckoutRequest.setRequestedBookId(rs.getInt(3));
                oCheckoutRequest.setStatus(rs.getString(4));
                oCheckoutRequest.setStatusUpdateDate(rs.getDate(5)); 
                oCheckoutRequest.setJoinBookCopySerialId(rs.getString(6));
                oCheckoutRequest.setJoinBookEntryISBN(rs.getString(7));
                oCheckoutRequest.setJoinBookEntryTitle(rs.getString(8));
                oCheckoutRequest.setJoinAccountFirstName(rs.getString(9));
                oCheckoutRequest.setJoinAccountLastName(rs.getString(10));

                oCheckoutRequests.add(oCheckoutRequest);
            }

            return oCheckoutRequests;
            } finally {
            if (preparedStatement != null) try { preparedStatement.close(); } catch (SQLException ignore) {}
            if (connection != null) try { connection.close(); } catch (SQLException ignore) {}
            }
    }

    public static List<OnlineCheckoutRequestInnerJoinBookEntryLeftJoinAccount> getApprovedCheckoutRequestsByUser(int id) throws SQLException, ClassNotFoundException {
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        List<OnlineCheckoutRequestInnerJoinBookEntryLeftJoinAccount> oCheckoutRequests = new ArrayList<OnlineCheckoutRequestInnerJoinBookEntryLeftJoinAccount>();

        Blob blobCover = null;
        byte[] byteCover = null;

        try {
            connection = connectToDB();

            String sql = "SELECT ocr.id, ocr.requester_id, ocr.requested_book_id, ocr.requested_copy_id, ocr.status, ocr.status_update_date, bc.serial_id, be.isbn, be.title, be.cover\n" + 
                "FROM online_checkout_requests ocr\n" + 
                "INNER JOIN book_entries be\n" + 
                "ON ocr.requested_book_id = be.id\n" + 
                "LEFT JOIN book_copies bc\n" + 
                "ON ocr.requested_copy_id = bc.id\n" +
                "LEFT JOIN checkout_records cr\n" + 
                "ON ocr.id = cr.online_checkout_request_id\n" +
                "WHERE ocr.status = 'Approved'\n" +
                "AND cr.online_checkout_request_id is NULL\n" + 
                "AND ocr.requester_id = ?\n" + 
                "ORDER BY ocr.id DESC";
 
            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setInt(1, id);
            ResultSet rs = preparedStatement.executeQuery();

            while(rs.next()){  
                OnlineCheckoutRequestInnerJoinBookEntryLeftJoinAccount oCheckoutRequest = new OnlineCheckoutRequestInnerJoinBookEntryLeftJoinAccount();
                oCheckoutRequest.setDbId(rs.getInt(1));
                oCheckoutRequest.setRequesterId(rs.getInt(2));
                oCheckoutRequest.setRequestedBookId(rs.getInt(3));
                oCheckoutRequest.setRequestedCopyId(rs.getInt(4));
                oCheckoutRequest.setStatus(rs.getString(5));
                oCheckoutRequest.setStatusUpdateDate(rs.getDate(6)); 
                oCheckoutRequest.setJoinBookCopySerialId(rs.getString(7));
                oCheckoutRequest.setJoinBookEntryISBN(rs.getString(8));
                oCheckoutRequest.setJoinBookEntryTitle(rs.getString(9));

                blobCover = rs.getBlob(10);
                byteCover = blobCover.getBytes(1l, (int)blobCover.length());
                oCheckoutRequest.setJoinBookEntryCover(new String(Base64.getEncoder().encode(byteCover)));

                oCheckoutRequests.add(oCheckoutRequest);
            }

            return oCheckoutRequests;
            } finally {
            if (preparedStatement != null) try { preparedStatement.close(); } catch (SQLException ignore) {}
            if (connection != null) try { connection.close(); } catch (SQLException ignore) {}
            }
    }

    public static List<OnlineCheckoutRequestInnerJoinBookEntryLeftJoinAccount> getCheckoutRequests() throws SQLException, ClassNotFoundException {
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        List<OnlineCheckoutRequestInnerJoinBookEntryLeftJoinAccount> oCheckoutRequests = new ArrayList<OnlineCheckoutRequestInnerJoinBookEntryLeftJoinAccount>();

        try {
            connection = connectToDB();

            String sql = "SELECT ocr.id, ocr.requester_id, ocr.requested_book_id, ocr.status, ocr.request_date, ocr.status_update_date, ocr.requested_copy_id, bc.serial_id, cr.id, be.isbn, be.title, ac.first_name, ac.last_name\n" + 
                "FROM online_checkout_requests ocr\n" + 
                "INNER JOIN book_entries be\n" + 
                "ON ocr.requested_book_id = be.id\n" + 
                "LEFT JOIN accounts ac\n" + 
                "ON ocr.requester_id = ac.id\n" +
                "LEFT JOIN book_copies bc\n" + 
                "ON ocr.requested_copy_id = bc.id\n" +
                "LEFT JOIN checkout_records cr\n" + 
                "ON cr.online_checkout_request_id = ocr.id\n" +
                "ORDER BY ocr.id DESC";

            preparedStatement = connection.prepareStatement(sql);
            ResultSet rs = preparedStatement.executeQuery();
            
            while(rs.next()){  
                OnlineCheckoutRequestInnerJoinBookEntryLeftJoinAccount oCheckoutRequest = new OnlineCheckoutRequestInnerJoinBookEntryLeftJoinAccount();
                oCheckoutRequest.setDbId(rs.getInt(1));
                oCheckoutRequest.setRequesterId(rs.getInt(2));
                oCheckoutRequest.setRequestedBookId(rs.getInt(3));
                oCheckoutRequest.setStatus(rs.getString(4));
                oCheckoutRequest.setRequestDate(rs.getDate(5)); 
                oCheckoutRequest.setStatusUpdateDate(rs.getDate(6));
                oCheckoutRequest.setRequestedCopyId(rs.getInt(7));
                oCheckoutRequest.setJoinBookCopySerialId(rs.getString(8));
                oCheckoutRequest.setJoinCheckoutRecordId(rs.getInt(9));
                oCheckoutRequest.setJoinBookEntryISBN(rs.getString(10));
                oCheckoutRequest.setJoinBookEntryTitle(rs.getString(11));
                oCheckoutRequest.setJoinAccountFirstName(rs.getString(12));
                oCheckoutRequest.setJoinAccountLastName(rs.getString(13));

                oCheckoutRequests.add(oCheckoutRequest);
            }

            return oCheckoutRequests;
         } finally {
            if (preparedStatement != null) try { preparedStatement.close(); } catch (SQLException ignore) {}
            if (connection != null) try { connection.close(); } catch (SQLException ignore) {}
         }
    }

    public static List<BookEntry> getBookEntriesForCatalog(String genre) throws SQLException, ClassNotFoundException {
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        Blob blobCover = null;
        byte[] byteCover = null;
        List<BookEntry> bookEntries = new ArrayList<BookEntry>();

        try {
            connection = connectToDB();

            String sql = "SELECT ISBN, title, authors, cover\n" +
                "FROM book_entries\n" +
                "WHERE genre = ?\n" + 
                "ORDER BY id DESC\n" +
                "LIMIT 6";

            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, genre);
            ResultSet rs = preparedStatement.executeQuery();
                            
            while(rs.next()){  
                BookEntry bookEntry = new BookEntry();
                bookEntry.setISBN(rs.getString(1));
                bookEntry.setTitle(rs.getString(2));
                bookEntry.setAuthors(rs.getString(3));

                blobCover = rs.getBlob(4);
                byteCover = blobCover.getBytes(1l, (int)blobCover.length());
                bookEntry.setCover(new String(Base64.getEncoder().encode(byteCover)));

                bookEntries.add(bookEntry);
            }

            return bookEntries;
         } finally {
            if (preparedStatement != null) try { preparedStatement.close(); } catch (SQLException ignore) {}
            if (connection != null) try { connection.close(); } catch (SQLException ignore) {}
         }
    }

    public static boolean hasPendingCheckoutRequestForBook(int userId, int bookEntryId) throws SQLException, ClassNotFoundException {
        Connection connection = null;
        Statement statement = null;

        try {
            connection = connectToDB();

            statement = connection.createStatement();
            String sql = "SELECT COUNT(*) AS recordCount\n" + 
                "FROM online_checkout_requests ocr\n" + 
                "LEFT JOIN checkout_records cr\n" + 
                "ON ocr.id = cr.online_checkout_request_id\n" +
                "WHERE requester_id = '" + userId + "' " +
                "AND requested_book_id = '" + bookEntryId + "' " +
                "AND ocr.status = 'Pending'\n" +
                "OR (ocr.status = 'Approved' AND cr.online_checkout_request_id IS NULL)";
            
            ResultSet rs = statement.executeQuery(sql);

            rs.next();

            int count = rs.getInt("recordCount");

            return count < 1 ? false:true; 
         } finally {
            if (statement != null) try { statement.close(); } catch (SQLException ignore) {}
            if (connection != null) try { connection.close(); } catch (SQLException ignore) {}
         }
    }

    public static void addCheckoutRequest(int userId, int bookEntryId) throws SQLException, ClassNotFoundException {
        Connection connection = null;
        Statement statement = null;

        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");  
        Date date = new Date();  
        String today = formatter.format(date);

        try {
            connection = connectToDB();

            statement = connection.createStatement();
            String sql = "INSERT INTO online_checkout_requests(requester_id, requested_book_id, request_date)\n" +
                "VALUES('"+userId+"','"+
                bookEntryId+"','"+
                today+"')";
            statement.executeUpdate(sql);
         } finally {
            if (statement != null) try { statement.close(); } catch (SQLException ignore) {}
            if (connection != null) try { connection.close(); } catch (SQLException ignore) {}
         }
    }

    public static List<CheckoutRecordInnerJoinBookEntryLeftJoinAccount> getCheckedOutBooksByUser(int userId) throws SQLException, ClassNotFoundException {
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        List<CheckoutRecordInnerJoinBookEntryLeftJoinAccount> checkoutRecords = new ArrayList<CheckoutRecordInnerJoinBookEntryLeftJoinAccount>();

        Blob blobCover = null;
        byte[] byteCover = null;

        try {
            connection = connectToDB();

            String sql = "SELECT cr.id, cr.book_entry_id, cr.book_copy_id, cr.borrower_id, cr.online_checkout_request_id, cr.checkout_date, cr.expected_return_date, cr.actual_return_date, cr.status, bc.serial_id, be.isbn, be.title, be.cover\n" + 
            "FROM checkout_records cr\n" + 
            "INNER JOIN book_entries be\n" + 
            "ON cr.book_entry_id = be.id\n" + 
            "LEFT JOIN book_copies bc\n" + 
            "ON cr.book_copy_id = bc.id\n" +
            "WHERE cr.borrower_id = ?\n" +
            "AND cr.status = 'Checked Out'\n" + 
            "ORDER BY cr.id DESC";

            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setInt(1, userId);

            ResultSet rs = preparedStatement.executeQuery();
            
            while(rs.next()){  
                CheckoutRecordInnerJoinBookEntryLeftJoinAccount checkoutRecord = new CheckoutRecordInnerJoinBookEntryLeftJoinAccount();
                checkoutRecord.setDbId(rs.getInt(1));
                checkoutRecord.setBookEntryId(2);
                checkoutRecord.setBookCopyId(rs.getInt(3));
                checkoutRecord.setBorrowerId(rs.getInt(4));
                checkoutRecord.setOnlineCheckoutRequestId(rs.getInt(5)  );
                checkoutRecord.setCheckoutDate(rs.getDate(6));
                checkoutRecord.setExpectedReturnDate(rs.getDate(7));
                checkoutRecord.setActualReturnDate(rs.getDate(8));
                checkoutRecord.setStatus(rs.getString(9));
                checkoutRecord.setJoinBookCopySerialId(rs.getString(10));
                checkoutRecord.setJoinBookEntryISBN(rs.getString(11));
                checkoutRecord.setJoinBookEntryTitle(rs.getString(12));

                blobCover = rs.getBlob(13);
                byteCover = blobCover.getBytes(1l, (int)blobCover.length());
                checkoutRecord.setJoinBookEntryCover(new String(Base64.getEncoder().encode(byteCover)));

                checkoutRecords.add(checkoutRecord);
            }

            return checkoutRecords;
         } finally {
            if (preparedStatement != null) try { preparedStatement.close(); } catch (SQLException ignore) {}
            if (connection != null) try { connection.close(); } catch (SQLException ignore) {}
         }
    }

    public static List<OnlineCheckoutRequestInnerJoinBookEntryLeftJoinAccount> getPendingCheckoutRequestsByUser(int id) throws SQLException, ClassNotFoundException {
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        List<OnlineCheckoutRequestInnerJoinBookEntryLeftJoinAccount> oCheckoutRequests = new ArrayList<OnlineCheckoutRequestInnerJoinBookEntryLeftJoinAccount>();

        Blob blobCover = null;
        byte[] byteCover = null;

        try {
            connection = connectToDB();

            String sql = "SELECT ocr.id, ocr.requester_id, ocr.requested_book_id, ocr.status, ocr.request_date, be.isbn, be.title, be.cover\n" + 
                "FROM online_checkout_requests ocr\n" + 
                "INNER JOIN book_entries be\n" + 
                "ON ocr.requested_book_id = be.id\n" + 
                "WHERE ocr.status = 'Pending'\n" +
                "AND ocr.requester_id = ?\n" +
                "ORDER BY ocr.id DESC";

            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setInt(1, id);
            ResultSet rs = preparedStatement.executeQuery();

            while(rs.next()){  
                OnlineCheckoutRequestInnerJoinBookEntryLeftJoinAccount oCheckoutRequest = new OnlineCheckoutRequestInnerJoinBookEntryLeftJoinAccount();
                oCheckoutRequest.setDbId(rs.getInt(1));
                oCheckoutRequest.setRequesterId(rs.getInt(2));
                oCheckoutRequest.setRequestedBookId(rs.getInt(3));
                oCheckoutRequest.setStatus(rs.getString(4));
                oCheckoutRequest.setRequestDate(rs.getDate(5)); 
                oCheckoutRequest.setJoinBookEntryISBN(rs.getString(6));
                oCheckoutRequest.setJoinBookEntryTitle(rs.getString(7));

                blobCover = rs.getBlob(8);
                byteCover = blobCover.getBytes(1l, (int)blobCover.length());
                oCheckoutRequest.setJoinBookEntryCover(new String(Base64.getEncoder().encode(byteCover)));

                oCheckoutRequests.add(oCheckoutRequest);
            }

            return oCheckoutRequests;
            } finally {
            if (preparedStatement != null) try { preparedStatement.close(); } catch (SQLException ignore) {}
            if (connection != null) try { connection.close(); } catch (SQLException ignore) {}
            }
    }

    public static List<OnlineCheckoutRequestInnerJoinBookEntryLeftJoinAccount> getCheckoutRequestsByUser(int id) throws SQLException, ClassNotFoundException {
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        List<OnlineCheckoutRequestInnerJoinBookEntryLeftJoinAccount> oCheckoutRequests = new ArrayList<OnlineCheckoutRequestInnerJoinBookEntryLeftJoinAccount>();

        try {
            connection = connectToDB();

            String sql = "SELECT ocr.id, ocr.requester_id, ocr.requested_book_id, ocr.status, ocr.request_date, ocr.status_update_date, ocr.requested_copy_id, bc.serial_id, cr.id, be.isbn, be.title\n" + 
                "FROM online_checkout_requests ocr\n" + 
                "INNER JOIN book_entries be\n" + 
                "ON ocr.requested_book_id = be.id\n" + 
                "LEFT JOIN book_copies bc\n" + 
                "ON ocr.requested_copy_id = bc.id\n" +
                "LEFT JOIN checkout_records cr\n" + 
                "ON cr.online_checkout_request_id = ocr.id\n" +
                "WHERE ocr.requester_id = ?\n" +
                "ORDER BY ocr.id DESC";

            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setInt(1, id);
            ResultSet rs = preparedStatement.executeQuery();
            
            while(rs.next()){  
                OnlineCheckoutRequestInnerJoinBookEntryLeftJoinAccount oCheckoutRequest = new OnlineCheckoutRequestInnerJoinBookEntryLeftJoinAccount();
                oCheckoutRequest.setDbId(rs.getInt(1));
                oCheckoutRequest.setRequesterId(rs.getInt(2));
                oCheckoutRequest.setRequestedBookId(rs.getInt(3));
                oCheckoutRequest.setStatus(rs.getString(4));
                oCheckoutRequest.setRequestDate(rs.getDate(5)); 
                oCheckoutRequest.setStatusUpdateDate(rs.getDate(6));
                oCheckoutRequest.setRequestedCopyId(rs.getInt(7));
                oCheckoutRequest.setJoinBookCopySerialId(rs.getString(8));
                oCheckoutRequest.setJoinCheckoutRecordId(rs.getInt(9));
                oCheckoutRequest.setJoinBookEntryISBN(rs.getString(10));
                oCheckoutRequest.setJoinBookEntryTitle(rs.getString(11));

                oCheckoutRequests.add(oCheckoutRequest);
            }

            return oCheckoutRequests;
         } finally {
            if (preparedStatement != null) try { preparedStatement.close(); } catch (SQLException ignore) {}
            if (connection != null) try { connection.close(); } catch (SQLException ignore) {}
         }
    }

    public static List<CheckoutRecordInnerJoinBookEntryLeftJoinAccount> getCheckoutRecordsByUser(int id) throws SQLException, ClassNotFoundException {
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        List<CheckoutRecordInnerJoinBookEntryLeftJoinAccount> checkoutRecords = new ArrayList<CheckoutRecordInnerJoinBookEntryLeftJoinAccount>();

        try {
            connection = connectToDB();

            String sql = "SELECT cr.id, cr.book_entry_id, cr.book_copy_id, cr.borrower_id, cr.online_checkout_request_id, cr.checkout_date, cr.expected_return_date, cr.actual_return_date, cr.status, bc.serial_id, be.isbn, be.title\n" + 
            "FROM checkout_records cr\n" + 
            "INNER JOIN book_entries be\n" + 
            "ON cr.book_entry_id = be.id\n" + 
            "LEFT JOIN book_copies bc\n" + 
            "ON cr.book_copy_id = bc.id\n" + 
            "WHERE cr.borrower_id = ?";

            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setInt(1, id);
            ResultSet rs = preparedStatement.executeQuery();
            
            while(rs.next()){  
                CheckoutRecordInnerJoinBookEntryLeftJoinAccount checkoutRecord = new CheckoutRecordInnerJoinBookEntryLeftJoinAccount();
                checkoutRecord.setDbId(rs.getInt(1));
                checkoutRecord.setBookEntryId(2);
                checkoutRecord.setBookCopyId(rs.getInt(3));
                checkoutRecord.setBorrowerId(rs.getInt(4));
                checkoutRecord.setOnlineCheckoutRequestId(rs.getInt(5)  );
                checkoutRecord.setCheckoutDate(rs.getDate(6));
                checkoutRecord.setExpectedReturnDate(rs.getDate(7));
                checkoutRecord.setActualReturnDate(rs.getDate(8));
                checkoutRecord.setStatus(rs.getString(9));
                checkoutRecord.setJoinBookCopySerialId(rs.getString(10));
                checkoutRecord.setJoinBookEntryISBN(rs.getString(11));
                checkoutRecord.setJoinBookEntryTitle(rs.getString(12));

                checkoutRecords.add(checkoutRecord);
            }

            return checkoutRecords;
         } finally {
            if (preparedStatement != null) try { preparedStatement.close(); } catch (SQLException ignore) {}
            if (connection != null) try { connection.close(); } catch (SQLException ignore) {}
         }
    }

    public static User getUserById(int id) throws SQLException, ClassNotFoundException {
        Connection connection = null;
        PreparedStatement preparedStatement = null;

        User user = null;
        
        try {
            connection = connectToDB();

            String sql = "SELECT first_name, last_name, email, contact_number\n" + 
            "FROM accounts\n" +
            "WHERE id = ?";

            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setInt(1, id);

            ResultSet rs = preparedStatement.executeQuery();
            
            while(rs.next()){  
                user = new User();
                user.setFirstName(rs.getString(1));
                user.setLastName(rs.getString(2));
                user.setEmail(rs.getString(3));
                user.setContactNumber(rs.getString(4));
            }

            return user;
         } finally {
            if (preparedStatement != null) try { preparedStatement.close(); } catch (SQLException ignore) {}
            if (connection != null) try { connection.close(); } catch (SQLException ignore) {}
         }
    }

    public static void editUser(int id, User user) throws SQLException, ClassNotFoundException {
        Connection connection = null;
        Statement statement = null;

        try {
            connection = connectToDB();

            statement = connection.createStatement();
            String sql = "UPDATE accounts\n" + 
                "SET first_name = '" + user.getFirstName() + "', " +
                "last_name = '" + user.getLastName() + "', " +
                "email = '" + user.getEmail() + "', " +
                "contact_number = '" + user.getContactNumber() + "'\n" +
                "WHERE ( id = '" + id +"')";
            
            statement.executeUpdate(sql);
         } finally {
            if (statement != null) try { statement.close(); } catch (SQLException ignore) {}
            if (connection != null) try { connection.close(); } catch (SQLException ignore) {}
         }
    }

    public static void approveCheckoutRequest(int id, int requestedCopyId) throws SQLException, ClassNotFoundException {
        Connection connection = null;
        Statement statement = null;
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");  
        Date date = new Date();  
        String today = formatter.format(date);

        try {
            connection = connectToDB();
            statement = connection.createStatement();
            String sql = "UPDATE online_checkout_requests\n" + 
                "SET status = " + "'Approved', " +
                "status_update_date = " + "'" + today + "', " +
                "requested_copy_id = " + "'" + requestedCopyId + "'\n" +
                "WHERE ( id = '" + id +"')";
            
            statement.executeUpdate(sql);
         } finally {
            if (statement != null) try { statement.close(); } catch (SQLException ignore) {}
            if (connection != null) try { connection.close(); } catch (SQLException ignore) {}
         }
    }

    public static void rejectCheckoutRequest(int id) throws SQLException, ClassNotFoundException {
        Connection connection = null;
        Statement statement = null;
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");  
        Date date = new Date();  
        String today = formatter.format(date);

        try {
            connection = connectToDB();
            statement = connection.createStatement();
            String sql = "UPDATE online_checkout_requests\n" + 
                "SET status = " + "'Rejected', " +
                "status_update_date = " + "'" + today + "'\n" + 
                "WHERE ( id = '" + id +"')";
            
            statement.executeUpdate(sql);
         } finally {
            if (statement != null) try { statement.close(); } catch (SQLException ignore) {}
            if (connection != null) try { connection.close(); } catch (SQLException ignore) {}
         }
    }

    public static void updateBookCopyStatusById(int id, String status) throws SQLException, ClassNotFoundException {
        Connection connection = null;
        Statement statement = null;

        try {
            connection = connectToDB();

            statement = connection.createStatement();
            String sql = "UPDATE book_copies\n" + 
                "SET status = " + "'" + status + "'\n" +
                "WHERE ( id = '" + id +"')";

            statement.executeUpdate(sql);
         } finally {
            if (statement != null) try { statement.close(); } catch (SQLException ignore) {}
            if (connection != null) try { connection.close(); } catch (SQLException ignore) {}
         }
    }

    public static OnlineCheckoutRequestInnerJoinBookEntryLeftJoinAccount getCheckoutRequestById(int id) throws SQLException, ClassNotFoundException {
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        
        OnlineCheckoutRequestInnerJoinBookEntryLeftJoinAccount oCheckoutRequest = null;

        try {
            connection = connectToDB();

            String sql = "SELECT ocr.id, ocr.requester_id, ocr.requested_book_id, ocr.status, ocr.request_date, ocr.status_update_date, ocr.requested_copy_id, bc.serial_id, cr.id, be.isbn, be.title, ac.first_name, ac.last_name\n" + 
                "FROM online_checkout_requests ocr\n" + 
                "INNER JOIN book_entries be\n" + 
                "ON ocr.requested_book_id = be.id\n" + 
                "LEFT JOIN accounts ac\n" + 
                "ON ocr.requester_id = ac.id\n" +
                "LEFT JOIN book_copies bc\n" + 
                "ON ocr.requested_copy_id = bc.id\n" +
                "LEFT JOIN checkout_records cr\n" + 
                "ON cr.online_checkout_request_id = ocr.id\n" +
                "WHERE ocr.id = ?\n" + 
                "ORDER BY ocr.id DESC";

            preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setInt(1, id);

            ResultSet rs = preparedStatement.executeQuery();
            
            while(rs.next()){  
                oCheckoutRequest = new OnlineCheckoutRequestInnerJoinBookEntryLeftJoinAccount();
                oCheckoutRequest.setDbId(rs.getInt(1));
                oCheckoutRequest.setRequesterId(rs.getInt(2));
                oCheckoutRequest.setRequestedBookId(rs.getInt(3));
                oCheckoutRequest.setStatus(rs.getString(4));
                oCheckoutRequest.setRequestDate(rs.getDate(5)); 
                oCheckoutRequest.setStatusUpdateDate(rs.getDate(6));
                oCheckoutRequest.setRequestedCopyId(rs.getInt(7));
                oCheckoutRequest.setJoinBookCopySerialId(rs.getString(8));
                oCheckoutRequest.setJoinCheckoutRecordId(rs.getInt(9));
                oCheckoutRequest.setJoinBookEntryISBN(rs.getString(10));
                oCheckoutRequest.setJoinBookEntryTitle(rs.getString(11));
                oCheckoutRequest.setJoinAccountFirstName(rs.getString(12));
                oCheckoutRequest.setJoinAccountLastName(rs.getString(13));
            }

            return oCheckoutRequest;
         } finally {
            if (preparedStatement != null) try { preparedStatement.close(); } catch (SQLException ignore) {}
            if (connection != null) try { connection.close(); } catch (SQLException ignore) {}
         }
    }

    public static void addCheckoutRecord(CheckoutRecord checkoutRecord) throws SQLException, ClassNotFoundException {
        Connection connection = null;
        Statement statement = null;

        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");  
        Date date = new Date();  
        String today = formatter.format(date);

        try {
            connection = connectToDB();

            statement = connection.createStatement();
            String sql = "INSERT INTO checkout_records(book_entry_id, book_copy_id, borrower_id, online_checkout_request_id, checkout_date, expected_return_date)\n" +
                "VALUES('"+
                checkoutRecord.getBookEntryId()+"','"+
                checkoutRecord.getBookCopyId()+"','"+
                checkoutRecord.getBorrowerId()+"','"+
                checkoutRecord.getOnlineCheckoutRequestId()+"','"+
                today+"','"+
                new java.sql.Date(checkoutRecord.getExpectedReturnDate().getTime())+"')";
            statement.executeUpdate(sql);
         } finally {
            if (statement != null) try { statement.close(); } catch (SQLException ignore) {}
            if (connection != null) try { connection.close(); } catch (SQLException ignore) {}
         }
    }

    public static List<CheckoutRecordInnerJoinBookEntryLeftJoinAccount> getLaterExpectedCheckins() throws SQLException, ClassNotFoundException {
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        List<CheckoutRecordInnerJoinBookEntryLeftJoinAccount> checkoutRecords = new ArrayList<CheckoutRecordInnerJoinBookEntryLeftJoinAccount>();
        try {
            connection = connectToDB();

            String sql = "SELECT cr.id, cr.book_entry_id, cr.book_copy_id, cr.borrower_id, cr.checkout_date, cr.expected_return_date, be.isbn, be.title, ac.first_name, ac.last_name\n" + 
            "FROM checkout_records cr\n" + 
            "INNER JOIN book_entries be\n" + 
            "ON cr.book_entry_id = be.id\n" + 
            "LEFT JOIN accounts ac\n" + 
            "ON cr.borrower_id = ac.id\n" + 
            "WHERE cr.expected_return_date > CURDATE()\n" +
            "AND cr.status = 'Checked Out'";

            preparedStatement = connection.prepareStatement(sql);

            ResultSet rs = preparedStatement.executeQuery();
            
            while(rs.next()){  
                CheckoutRecordInnerJoinBookEntryLeftJoinAccount checkoutRecord = new CheckoutRecordInnerJoinBookEntryLeftJoinAccount();
                checkoutRecord.setDbId(rs.getInt(1));
                checkoutRecord.setBookEntryId(2);
                checkoutRecord.setBookCopyId(rs.getInt(3));
                checkoutRecord.setBorrowerId(rs.getInt(4));
                checkoutRecord.setCheckoutDate(rs.getDate(5));
                checkoutRecord.setExpectedReturnDate(rs.getDate(6));
                checkoutRecord.setJoinBookEntryISBN(rs.getString(7));
                checkoutRecord.setJoinBookEntryTitle(rs.getString(8));
                checkoutRecord.setJoinAccountFirstName(rs.getString(9));
                checkoutRecord.setJoinAccountLastName(rs.getString(10));

                checkoutRecords.add(checkoutRecord);
            }

            return checkoutRecords;
         } finally {
            if (preparedStatement != null) try { preparedStatement.close(); } catch (SQLException ignore) {}
            if (connection != null) try { connection.close(); } catch (SQLException ignore) {}
         }
    }

    public static List<CheckoutRecordInnerJoinBookEntryLeftJoinAccount> getCheckoutRecords() throws SQLException, ClassNotFoundException {
        Connection connection = null;
        PreparedStatement preparedStatement = null;
        List<CheckoutRecordInnerJoinBookEntryLeftJoinAccount> checkoutRecords = new ArrayList<CheckoutRecordInnerJoinBookEntryLeftJoinAccount>();

        try {
            connection = connectToDB();

            String sql = "SELECT cr.id, cr.book_entry_id, cr.book_copy_id, cr.borrower_id, cr.online_checkout_request_id, cr.checkout_date, cr.expected_return_date, cr.actual_return_date, cr.status, be.isbn, be.title, ac.first_name, ac.last_name\n" + 
            "FROM checkout_records cr\n" + 
            "INNER JOIN book_entries be\n" + 
            "ON cr.book_entry_id = be.id\n" + 
            "LEFT JOIN accounts ac\n" + 
            "ON cr.borrower_id = ac.id";

            preparedStatement = connection.prepareStatement(sql);

            ResultSet rs = preparedStatement.executeQuery();
            
            while(rs.next()){  
                CheckoutRecordInnerJoinBookEntryLeftJoinAccount checkoutRecord = new CheckoutRecordInnerJoinBookEntryLeftJoinAccount();
                checkoutRecord.setDbId(rs.getInt(1));
                checkoutRecord.setBookEntryId(2);
                checkoutRecord.setBookCopyId(rs.getInt(3));
                checkoutRecord.setBorrowerId(rs.getInt(4));
                checkoutRecord.setOnlineCheckoutRequestId(rs.getInt(5));
                checkoutRecord.setCheckoutDate(rs.getDate(6));
                checkoutRecord.setExpectedReturnDate(rs.getDate(7));
                checkoutRecord.setActualReturnDate(rs.getDate(8));
                checkoutRecord.setStatus(rs.getString(9));
                checkoutRecord.setJoinBookEntryISBN(rs.getString(10));
                checkoutRecord.setJoinBookEntryTitle(rs.getString(11));
                checkoutRecord.setJoinAccountFirstName(rs.getString(12));
                checkoutRecord.setJoinAccountLastName(rs.getString(13));

                checkoutRecords.add(checkoutRecord);
            }

            return checkoutRecords;
         } finally {
            if (preparedStatement != null) try { preparedStatement.close(); } catch (SQLException ignore) {}
            if (connection != null) try { connection.close(); } catch (SQLException ignore) {}
         }
    }

    public static void checkinCheckoutRecord(int id) throws SQLException, ClassNotFoundException {
        Connection connection = null;
        Statement statement = null;

        try {
            connection = connectToDB();

            statement = connection.createStatement();
            String sql = "UPDATE checkout_records\n" + 
                "SET actual_return_date = CURDATE(), " +
                "status = 'Checked In'\n" +
                "WHERE ( id = '" + id +"')";
            
            statement.executeUpdate(sql);
         } finally {
            if (statement != null) try { statement.close(); } catch (SQLException ignore) {}
            if (connection != null) try { connection.close(); } catch (SQLException ignore) {}
         }
    }

    public static void checkinBookCopy(int id) throws SQLException, ClassNotFoundException {
        Connection connection = null;
        Statement statement = null;

        try {
            connection = connectToDB();

            statement = connection.createStatement();
            String sql = "UPDATE book_copies\n" + 
                "SET status = 'Available'\n" +
                "WHERE ( id = '" + id +"')";
            
            statement.executeUpdate(sql);
         } finally {
            if (statement != null) try { statement.close(); } catch (SQLException ignore) {}
            if (connection != null) try { connection.close(); } catch (SQLException ignore) {}
         }
    }

    public static void cancelCheckoutRequest(int id) throws SQLException, ClassNotFoundException {
        Connection connection = null;
        Statement statement = null;
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");  
        Date date = new Date();  
        String today = formatter.format(date);

        try {
            connection = connectToDB();
            statement = connection.createStatement();
            String sql = "UPDATE online_checkout_requests\n" + 
                "SET status = " + "'Canceled', " +
                "status_update_date = " + "'" + today + "'\n" +
                "WHERE ( id = '" + id +"')";
            
            statement.executeUpdate(sql);
         } finally {
            if (statement != null) try { statement.close(); } catch (SQLException ignore) {}
            if (connection != null) try { connection.close(); } catch (SQLException ignore) {}
         }
    }
    /////////////////////////////////////////////////////////////////
}
