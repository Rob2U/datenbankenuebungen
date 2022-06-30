import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class JDBCExerciseMain {
    public static void main(String[] args) throws SQLException{
        String[] arguments = parseArguments(args);
        String dbURL = arguments[0];
        String keyword = arguments[1];

        //System.out.println("StringURL: " + dbURL + "\t " + username + "\t " + password);

        Connection conn = DriverManager.getConnection(dbURL);

        System.out.println(conn.getMetaData().getDatabaseProductName());
        System.out.println(conn.getMetaData().getDatabaseMajorVersion());

        // teilaufgabe a b
        PreparedStatement pstmta = conn.prepareStatement("SELECT title, year, mid FROM movie WHERE LOWER(title) LIKE CONCAT('%',LOWER(?),'%') ORDER BY title ASC;");
        pstmta.setString(1,keyword);
        ResultSet resultseta = pstmta.executeQuery();
        System.out.println("MOVIES");

        while (resultseta.next()){
            System.out.println("\n---------------------------------------------------------------\n");
            System.out.print(resultseta.getString(1) + "," + resultseta.getString(2));
            String movieId = resultseta.getString(3);

            ArrayList<String> genres = getGenres(movieId, conn);
            for (int i = 0; i < genres.size(); i++) {
                System.out.print(", " + genres.get(i));
            }

            ArrayList<String> actors = getActorsGenderNeutral(movieId, conn);

            for (int i = 0; i < actors.size(); i++) {
                System.out.print( "\n\t\t" + actors.get(i));
            }
            System.out.println();
        }
        System.out.println();
        // teilaufgabe c d

        //get all matching actors
        PreparedStatement pstmtc = conn.prepareStatement("SELECT DISTINCT name FROM " +
                "(SELECT * FROM actor UNION SELECT * FROM actress) as actors " +
                " WHERE LOWER(name) LIKE CONCAT('%',LOWER(?),'%') ORDER BY name ASC;");
        pstmtc.setString(1,keyword);
        ResultSet resultsetc = pstmtc.executeQuery();
        System.out.println("ACTORS");

        while (resultsetc.next()) {
            System.out.println(resultsetc.getString(1));
            // get corresponding movies
            System.out.println("\t\tPLAYED IN");
            ArrayList<String> playedIn = getMoviesPlayedIn(resultsetc.getString(1), conn);
            for (int i = 0; i < playedIn.size(); i++) {
                System.out.println("\t\t\t\t" + playedIn.get(i));
            }
            // get CO-Stars
            System.out.println("\t\tCO-STARS");
            ArrayList<String> coStars = getCoStars(resultsetc.getString(1) ,conn);

            for (int i = 0; i < coStars.size(); i++) {
                System.out.println("\t\t\t\t" + coStars.get(i));
            }
        }
    }

    public static ArrayList<String> getCoStars(String actor, Connection conn) throws  SQLException{
        PreparedStatement stmt = conn.prepareStatement("SELECT coactor.name, COUNT(coactor.name) AS anzahlfilme FROM " +
                "(SELECT * FROM actor UNION SELECT * FROM actress) as coactor," +
                "(SELECT * FROM actor UNION SELECT * FROM actress) as actors " +
                "WHERE actors.name=? AND actors.movie_id=coactor.movie_id  AND coactor.name <> actors.name GROUP BY coactor.name " +
                "ORDER BY anzahlfilme DESC, coactor.name ASC LIMIT 5;");
        stmt.setString(1, actor);
        ResultSet resultSet = stmt.executeQuery();
        ArrayList<String> result = new ArrayList<String>();

        while (resultSet.next()) {
            result.add(resultSet.getString(1) + " (" + resultSet.getString(2) + ")");
        }
        return  result;
    }
     public static ArrayList<String> getMoviesPlayedIn(String actor, Connection conn) throws SQLException {
         PreparedStatement stmt = conn.prepareStatement("SELECT movie.title FROM movie, (SELECT * FROM actor UNION SELECT * FROM actress) as actors WHERE actors.name = ? AND mid=movie_id;");
         stmt.setString(1, actor);
         ResultSet resultSet = stmt.executeQuery();
         ArrayList<String> result = new ArrayList<String>();

         while (resultSet.next()) {
             result.add(resultSet.getString(1));
         }
         return result;
     }

    public static ArrayList<String> getGenres(String movieId, Connection conn) throws SQLException {
        PreparedStatement pStmt = conn.prepareStatement("SELECT genre FROM genre WHERE movie_id=?;");
        pStmt.setString(1, movieId);

        ResultSet resultSet = pStmt.executeQuery();
        ArrayList<String> genres = new ArrayList<String>();

        while (resultSet.next()) {
            genres.add(resultSet.getString(1));
        }
        return genres;
    }

    public static ArrayList<String> getActorsGenderNeutral(String movieId, Connection conn) throws SQLException {
        PreparedStatement pStmt = conn.prepareStatement("SELECT name FROM (SELECT * FROM actor UNION SELECT * FROM actress) as actors WHERE movie_id=? ORDER BY name ASC LIMIT 5;");
        pStmt.setString(1, movieId);

        ResultSet resultSet = pStmt.executeQuery();
        ArrayList<String> actors = new ArrayList<String>();

        while (resultSet.next()) {
            actors.add(resultSet.getString(1));
        }
        return actors;
    }

    public static String[] parseArguments(String[] argsString) {
        String dbName = "imdb";
        String ip = "127.0.0.1";
        String port = "5432";
        String userName = "username";
        String password = "password";
        String keyword = "";

        for(int i = 0; i < (argsString.length/2)*2; i+=2) {
            switch (argsString[i]){
                case "-d":
                    dbName = argsString[i+1];
                    break;
                case "-s":
                    ip = argsString[i+1];
                    break;
                case "-p":
                    port = argsString[i+1];
                    break;
                case "-u":
                    userName = argsString[i+1];
                    break;
                case "-pwd":
                    password = argsString[i+1];
                    break;
                case "-k":
                    keyword = argsString[i+1];
                    break;
                default:
                    break;
            }

        }

        String databaseURL = String.format("jdbc:postgresql://%s/%s?user=%s&password=%s&port=%s", ip, dbName, userName, password, port);
        return new String[]{databaseURL,keyword};
    }
}
