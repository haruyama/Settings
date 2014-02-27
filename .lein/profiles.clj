{:user {:plugins [[codox "0.6.7"]
                  [jonase/eastwood "0.1.0"]
                  [lein-ancient    "0.5.4"]
                  [lein-bikeshed   "0.1.6"]
                  [lein-cloverage  "1.0.2"]
                  [lein-difftest   "2.0.0"]
                  [lein-exec "0.3.2"]
                  [lein-licenses   "0.1.1"]
                  [lein-localrepo  "0.5.3"]
                  [lein-marginalia "0.7.1"]
                  [lein-midje    "3.1.3"]
                  [lein-midje-doc "0.0.18"]
                  [lein-kibit      "0.0.8"]
                  [lein-pprint     "1.1.1"]
                  [lein-try        "0.4.1"]
                  [lein-typed      "0.3.2"]
                  [perforate       "0.3.3"]]
        :search-page-size 30
        :dependencies [[org.clojure/tools.namespace "0.2.4"]
;                       [im.chit/vinyasa "0.1.8"]
                       [io.aviso/pretty "0.1.9"]
                       [jonase/kibit "0.0.8"]
                       [spyscope "0.1.4"]]
        :injections  [(require 'spyscope.core)
;                      (require 'vinyasa.inject)
;                      (vinyasa.inject/inject 'clojure.core
;                                             '[[vinyasa.inject [inject inject]]
;                                               [vinyasa.pull [pull pull]]
                                ;               [vinyasa.lein [lein lein]]
;                                               [clojure.tools.namespace.repl [refresh refresh]]
;                                               [clojure.pprint [pprint >pprint]]
;                                               [io.aviso.binary [write-binary >bin]]])
                      (require 'io.aviso.repl
                               'clojure.repl
                               'clojure.main)
                      (alter-var-root #'clojure.main/repl-caught
                                      (constantly @#'io.aviso.repl/pretty-pst))
                      (alter-var-root #'clojure.repl/pst
                                      (constantly @#'io.aviso.repl/pretty-pst))]
        :jvm-opts ["-XX:+TieredCompilation" "-XX:TieredStopAtLevel=1"]}}
