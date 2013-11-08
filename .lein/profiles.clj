{:user  {:plugins [[lein-ancient "0.5.2"]
                   [lein-bikeshed "0.1.3"]
                   [lein-difftest "2.0.0"]
                   [lein-licenses "0.1.1"]
                   [lein-localrepo "0.5.2"]
                   [lein-kibit "0.0.8"]
                   [lein-pprint   "1.1.1"]
                   [lein-try "0.4.0"] ]
         :search-page-size 30
         ; :repl-options  {:prompt  (fn  [ns]  (str "your command, master? "))}
         :jvm-opts ["-XX:+TieredCompilation" "-XX:TieredStopAtLevel=1"]
;         :jvm-opts [] ; for grenchman
         }}
