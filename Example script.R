setwd("~/Desktop/data/Spotify") #set working directory
install.packages("spotifyr")
install.packages("rjson")
install.packages("tidyverse")
install.packages("dplyr")
install.packages("RColorBrewer")

library(RColorBrewer)
library(spotifyr)
library(rjson)
library(tidyverse)
library(dplyr)

#Using Spotify API
Sys.setenv(SPOTIFY_CLIENT_ID = "CLIENT ID") #you have to sign up and request here https://developer.spotify.com/dashboard/login 
Sys.setenv(SPOTIFY_CLIENT_SECRET = "CLIENT SECRET")
access_token <- get_spotify_access_token()

#getting audio features from a playlist 
BoonTop <- get_playlist_audio_features(spotify, "Playlist ID")

#create dataframe with selected attributes 
Boon <- data_frame("track"= BoonTop$track.name, "popularity"= BoonTop$track.popularity, "danceability"= BoonTop$danceability, "energy"= BoonTop$energy, "key"= BoonTop$key, "loudness"= BoonTop$loudness, "mode"= BoonTop$mode, "speechiness"= BoonTop$speechiness, "acousticness"= BoonTop$acousticness, "instrumentalness"= BoonTop$instrumentalness, "liveness"= BoonTop$liveness, "valence"= BoonTop$valence, "tempo"= BoonTop$tempo, "duration"= BoonTop$track.duration_ms)

#export dataframe in the format of csv
write_csv(BoonTop, "Boon Top.csv")

#I did t-test to compare some audio features of 2 playlists/datasets. 
t.test(dat.Boon$duration, dat.US$duration)

#combine 2 data frames into 1 (called combined) with a variable "combine" (containing either Boon's Top Songs or Spotify Top Songs depending on where does it come from) to identify where they are from
dat.Boon$combine <- "Boon's Top Songs"
dat.US$combine <- "Spotify Top Songs"
combined <- rbind(dat.Boon, dat.US)

#density plot the danceability value 
ggplot(combined, aes(danceability, fill = combine)) + geom_density(alpha = 0.2)

#histogram plot of danceability
ggplot(combined, aes(danceability, fill = combine)) + 
  geom_histogram(alpha = 0.7, position = 'identity') +
  ggtitle("Danceability") +
  theme_minimal(base_size = 11) +
  scale_fill_discrete(name = "Legend")