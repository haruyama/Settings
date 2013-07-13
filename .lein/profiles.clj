{:user  {:plugins [[lein-kibit "0.0.8"]
                   [lein-difftest "2.0.0"]
                   [lein-pprint   "1.1.1"]
                   [lein-localrepo "0.4.1"]
                   [lein-try "0.1.1"]
                   [lein-licenses "0.1.1"]]
         :search-page-size 30
         ; :repl-options  {:prompt  (fn  [ns]  (str "your command, master? "))}
         :jvm-opts ["-XX:+TieredCompilation" "-XX:TieredStopAtLevel=1"]}}
