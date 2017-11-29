<?php

    include 'imdb.php';
    $data = scrape_imdb(2015,2018,3,5);
    
    
    $host = 'localhost';
    $user = ''; //DB Username
    $password = '';//DB Password
    $db = '';//DB
    
    $mysqli = new mysqli($host, $user, $password, $db);
    
    for ($i = 0; $i < count($data); $i++) {
        $description = $mysqli->escape_string($data[$i]['description']);
        $title = $mysqli->escape_string($data[$i]['title']);
        $slug = str_replace(' ', '-', $title);
        $slug = preg_replace('/[^A-Za-z0-9\-]/', '', $slug);
        $slug = strtolower($slug);
        
        
        $sql = "INSERT IGNORE INTO movies (title, slug, description, movie_length, release_date, release_info, img_url, metascore, status)"
                . "VALUES ('$title','$slug','{$data[$i]['description']}','{$data[$i]['runtime']}','{$data[$i]['year']}', '{$data[$i]['release_info']}', '{$data[$i]['image']}','{$data[$i]['metascore']}','{$data[$i]['status']}')";
           
        $mysqli->query($sql);      
        // $mysqli->query($sql) or die($mysqli->error);
        $movies_id = $mysqli->insert_id;
        
        if (!$movies_id){
            continue;
        }
        
        
        $directors = explode(',',$data[$i]['directors']);
        $stars = explode(',',$data[$i]['stars']);
        $genres = explode(',',$data[$i]['genres']);
        
        //Directors
        for($d = 0; $d < count($directors); $d++){
            $director = $mysqli->escape_string(trim($directors[$d]));
            
            $sql = "INSERT IGNORE INTO directors (name) VALUES ('$director')";
            
            $mysqli->query($sql) or die($mysqli->error);
            
            $directors_id = $mysqli->insert_id;

            if ($directors_id){
                $sql = "INSERT IGNORE INTO movies_directors (movies_id, directors_id) VALUES ('$movies_id' ,'$directors_id')";
                $mysqli->query($sql) or die($mysqli->error);
            }
            else {
                $sql = "SELECT id FROM directors WHERE name='$director'";
                $result = $mysqli->query($sql);
                $row = $result->fetch_assoc();
                $directors_id = $row['id'];
                
                $sql = "INSERT IGNORE INTO movies_directors (movies_id, directors_id) VALUES ('$movie_id' ,'$directors_id')";
                $mysqli->query($sql) or die($mysqli->error);
            }
        }
        
        //Stars
        for($d = 0; $d < count($stars); $d++){
            $star = $mysqli->escape_string(trim($stars[$d]));
            
            $sql = "INSERT IGNORE INTO stars (name) VALUES ('$star')";
            
            $mysqli->query($sql);
            
            $stars_id = $mysqli->insert_id;
            if ($stars_id){
                $sql = "INSERT IGNORE INTO movies_stars (movies_id, stars_id) VALUES ('$movies_id' ,'$stars_id')";
                $mysqli->query($sql);
            }
            else {
                $sql = "SELECT id FROM stars WHERE name='$star'";
                $result = $mysqli->query($sql);
                $row = $result->fetch_assoc();
                $stars_id = $row['id'];
                
                $sql = "INSERT IGNORE INTO movies_stars (movies_id, stars_id) VALUES ('$movies_id' ,'$stars_id')";
                $mysqli->query($sql);
            }
        }
        
        //Genres CHANGE WHEN DB IS FIXED UFK
        for($d = 0; $d < count($genres); $d++){
            $genre = $mysqli->escape_string(trim($genres[$d]));
            
            $sql = "INSERT IGNORE INTO genres (name) VALUES ('$genre')";
            
            $mysqli->query($sql);
            
            $genres_id = $mysqli->insert_id;
            if ($genres_id){
                $sql = "INSERT IGNORE INTO movies_genres (movies_id, genres_id) VALUES ('$movies_id' ,'$genres_id')";
                $mysqli->query($sql);
            }
            else {
                $sql = "SELECT id FROM genres WHERE name='$genre'";
                $result = $mysqli->query($sql);
                $row = $result->fetch_assoc();
                $genres_id = $row['id'];
                
                $sql = "INSERT IGNORE INTO movies_genres (movies_id, genres_id) VALUES ('$movies_id' ,'$genres_id')";
                $mysqli->query($sql);
            }
        }
        
        
    }
    
    echo '<h1>Done!!</h1>';

?>