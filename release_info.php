<?php

    
function get_release_info($imdb_movie_id) {
    
    $curl = curl_init(); 

    $url = "http://www.imdb.com/$imdb_movie_id";

    curl_setopt($curl, CURLOPT_URL, $url);
    curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
    
    $result = curl_exec($curl);
    
    preg_match('<meta itemprop="datePublished" content="(.*?)">',$result,$match);
    
    return $match[1];
}

?>