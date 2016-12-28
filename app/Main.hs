module Main where

import Web.Slack
import Web.Slack.Message
import System.Environment (lookupEnv)
import Data.Maybe (fromMaybe)
import Control.Applicative

config :: String -> SlackConfig
config apiToken = SlackConfig
       { _slackApiToken = apiToken -- Specify your API token here
       }

haskellBot :: SlackBot ()
haskellBot (Message cid _ msg _ _ _) = sendMessage cid msg
haskellBot _ = return ()

main :: IO ()
main = do
  apiToken <- fromMaybe (error "SLACK_API_TOKEN not set")
               <$> lookupEnv "SLACK_API_TOKEN"
  runBot (config apiToken) haskellBot ()
