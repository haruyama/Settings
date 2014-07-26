;;
;; text-adjust.el ���ܸ��ʸ�Ϥ���������. 
;;
;;  By ��������  Hiroyuki Komatsu <komatsu@taiyaki.org>
;;
;; ���Υ����ɤ� GPL �˽��ä����۲�ǽ�Ǥ�. (This is GPLed software.)
;; 
;; �����󥹥ȡ�����ˡ
;; 1) Ŭ���ʥǥ��쥯�ȥ�ˤ��Υե������ mell.el �򤪤�.
;;    (~/elisp/ ��ˤ������Ȥ���). mell.el �ΰ층���۸���
;;    http://www.taiyaki.org/elisp/mell/ �Ǥ�.
;;
;; 2) .emacs �˼��� 2 �Ԥ��ɲä���.
;; (setq load-path (cons (expand-file-name "~/elisp") load-path))
;; (load "text-adjust")
;; 
;; ���Ȥ���
;; 1) M-x text-adjust ��¹Ԥ����ʸ�Ϥ����������.
;; 2) ���Ѳ�ǽ�ʴؿ��γ���.
;;     text-adjust-codecheck : Ⱦ�ѥ���, ���ʳ�ʸ����֢��פ��֤�������.
;;     text-adjust-hankaku   : ���ѱѿ�ʸ����Ⱦ�Ѥˤ���.
;;     text-adjust-kutouten  : ���������, �ס�. �פ��֤�������.
;;     text-adjust-space     : ����ʸ����Ⱦ��ʸ���δ֤˶���������.
;;     text-adjust           : �����򤹤٤Ƽ¹Ԥ���.
;;     text-adjust-fill      : ������ͥ���, fill-region �򤹤�.
;;    Ŭ���ϰϤϥ꡼����󤬤�����Ϥ����ϰϤ�,
;;    �ʤ���� mark-paragraph ������줿��. 
;;
;;     *-region : �嵭�ؿ���꡼�������Ǽ¹Ԥ���.
;;     *-buffer : �嵭�ؿ���Хåե���Ǽ¹Ԥ���.
;; 
;;
;; ��Tips
;; 1) ���Τ褦�����ꤹ���, text-adjust-fill-region �¹Ի���, 
;;  ���ޡ����󤬹�θ�����.
;;  | (setq adaptive-fill-regexp "[ \t]*")
;;  | (setq adaptive-fill-mode t)
;;
;; 2) ���������Ѷ����Ⱦ�Ѥ��Ѵ����ʤ��褦�ˤ���ˤ�.
;;  text-adjust-hankaku-except ��ʸ�����ɲä���в�ǽ�ˤʤ�ޤ�.
;;  | (setq text-adjust-hankaku-except "��������������������")
;;

(require 'mell)

(defvar text-adjust-hankaku-except "��������������"
  "text-adjust-hankaku ��Ⱦ�Ѥˤ��줿���ʤ�ʸ����. ����ɽ���ǤϤʤ�.")

;; text-adjust-rule �Υե����ޥåȤ�
;; (("��üʸ����" "�о�ʸ����" "��üʸ����") "�Ѵ�ʸ����") �Ȥ���������
;; �ꥹ�ȤǤ�. "��üʸ����", "�о�ʸ����", "��üʸ����" ������ɽ����
;; ���Ҳ�ǽ�Ǥ��� 3 �� ��Ϣ�뤷��ʸ����˥ޥå������Ľ���Ѵ��оݤȤ�, 
;; "�о�ʸ����" �� "�Ѵ�ʸ����" ���Ѵ����ޤ�.
;;
;; ����1
;; (("����" " " "����")   "|��|")
;; �Ѵ��� = "���� ����",  �Ѵ��� = "����|��|����"
;;
;; ����2
;; ((("\\cj"        "" "[0-9a-zA-Z]")   " ")
;;  (("[0-9a-zA-Z]" "" "\\cj")          " "))
;; �Ѵ��� = "You��Shoooock!",  �Ѵ��� = "You �� Shoooock!"
;;
;; "�Ѵ�ʸ����" �Ǥ� "{", "}" ���Ѥ����ȼ���ˡ�ˤ�ä��о�ʸ�����
;; ���Ȥ��뤳�Ȥ���ǽ�Ǥ�. "{1}", "{2}", "{3}" �Ϥ��줾���� "��üʸ����",
;; "�о�ʸ����", "��üʸ����" �����Τ�ɽ�路, "{2-3}" �� "�о�ʸ����" ��
;; 3 ���ܤ�����ɽ���γ�̤��б����ޤ�. �ޤ�, "{1}" �� "{1-0}" ��Ʊ�ͤǤ�.
;;
;; ����3
;; (("��" "�п���" "��") "{1}{2}{3}")
;; �Ѵ��� = "��п��ڶ�", �Ѵ��� = "���п��ڶ��"
;;
;; ����4
;; (("" "\\(.��\\)\\(.��\\)" "") "{2-2}{2-1}")
;; �Ѵ��� = "�������Υ���ޥ�", �Ѵ��� = "�������Υޥ󥬥�"
;;
;; text-adjust-mode-skip-rule �ϳƥ⡼�ɤ��ò������ü��Ѵ��롼���, 
;; ����Ѵ��򤵤������ʤ��Ľ�򥹥��åפ�����Ū���Ѱդ���Ƥ��ޤ�.
;; text-adjust-rule-space, text-adjust-rule-kutouten, 
;; text-adjust-rule-codecheck �Τ��줾�����Ƭ���ɲä��줿�Τ�, �¹Ԥ���ޤ�.


;; ���ܸ�������ɽ�� (M-x describe-category �򻲾�)
;\\cK ��������
;\\cC ����
;\\cH �Ҥ餬��
;\\cS ���ѵ���
;\\cj ���ܸ� (�嵭����)
;\\ck Ⱦ�ѥ���
(defvar text-adjust-rule-space 
  '((("\\cj\\|)" "" "[[(0-9a-zA-Z+]")   " ")
    (("[])/!?0-9a-zA-Z+]" "" "(\\|\\cj") " "))
  "�ִ����������Ѵ��롼��.")

(defvar text-adjust-rule-kutouten-hperiod
  '((("\\cA\\|\\ca" "��" "\\cA\\|\\ca")   ".")
    (("" "[����] ?\\([)�ס�]?\\) *" "$")  "{2-1},")
    (("" "[����] ?\\([)�ס�]?\\) ?" "")   "{2-1}, ")
    (("" "[����] ?\\([)�ס�]?\\) *" "$")  "{2-1}.")
    (("" "[����] ?\\([)�ס�]?\\) ?" "")   "{2-1}. ")
    )
  "��,.����, ���������Ѵ��롼��.")

(defvar text-adjust-rule-kutouten-zperiod
  '((("" "�� ?\\([)�ס�]?\\)" "")     "{2-1}��")
    (("" "�� ?\\([)�ס�]?\\)" "")     "{2-1}��")
    (("\\cj" ", ?\\([)�ס�]?\\)" "")   "{2-1}��")
    (("\\cj" "\\. ?\\([)�ס�]?\\)" "") "{2-1}��"))
  "�֡�������, ���������Ѵ��롼��.")

(defvar text-adjust-rule-kutouten-zkuten
  '((("" "�� ?\\([)�ס�]?\\)" "")     "{2-1}��")
    (("" "�� ?\\([)�ס�]?\\)" "")     "{2-1}��")
    (("\\cj" ", ?\\([)�ס�]?\\)" "")   "{2-1}��")
    (("\\cj" "\\. ?\\([)�ס�]?\\)" "") "{2-1}��"))
  "�֡�������, ���������Ѵ��롼��.")

(defvar text-adjust-rule-kutouten text-adjust-rule-kutouten-hperiod
  "�ִ�������������Ѵ��롼��.
nil �ξ��, �Хåե����Ȥ������ǽ.")

(defvar text-adjust-rule-codecheck
  '((("" "\\ck\\|\\c@" "") "��")
    ))

(defvar text-adjust-mode-skip-rule '((sgml-mode . ((("<" "[^>]*" ">") "{2}")
						   ))))

;(defvar text-adjust-fill-regexp ", \\|\\. \\|! \\|\\? \\|��\\| ")
;(defvar text-adjust-fill-regexp "[,.!?] \\|[�� ]"
(defvar text-adjust-fill-regexp "[,!] \\|[�� ]"
  "��������ɽ���μ���ͥ�褷�Ʋ��Ԥ���.")
(defvar text-adjust-fill-start 60
  "�ƹԤȤ�, �����ͤ��� fill-column �ޤǤ��ͤޤǤ�\
 text-adjust-fill ��ͭ���ϰ�.")

(global-set-key [(meta zenkaku-hankaku)] 'text-adjust)


;;;; text-adjust
(defun text-adjust (&optional force-kutouten-rule)
  "���ܸ�ʸ�Ϥ���������.
�ƴؿ� text-adjust-codecheck, text-adjust-hankaku, text-adjust-kutouten,
text-adjust-space ���˼¹Ԥ��뤳�Ȥˤ��,
�ѿ����򤸤�����ܸ�ʸ�Ϥ���������.
�꡼�����λ��꤬���ä����Ϥ����ϰϤ�, �ʤ���� mark-paragraph �ˤ�ä�
����줿�ϰϤ��оݤˤ���."
  (interactive "P")
  (save-excursion
    (or (transient-region-active-p)
	(mark-paragraph))
    (text-adjust-region (region-beginning) (region-end) force-kutouten-rule)))

(defun text-adjust-buffer (&optional force-kutouten-rule)
  "�Хåե���Ǵؿ� text-adjust ��¹Ԥ���."
  (interactive "P")
  (text-adjust-region (point-min) (point-max) force-kutouten-rule))

(defun text-adjust-region (from to &optional force-kutouten-rule) 
  "�꡼�������Ǵؿ� text-adjust ��¹Ԥ���."
  (interactive "r\nP")
  (text-adjust-kutouten-read-rule force-kutouten-rule)
  (save-restriction
    (narrow-to-region from to)
    (text-adjust-codecheck-region (point-min) (point-max))
    (text-adjust-hankaku-region (point-min) (point-max))
    (text-adjust-kutouten-region (point-min) (point-max))
    (text-adjust-space-region (point-min) (point-max))
;    (text-adjust-fill)
    ))


;;;; text-adjust-codecheck
;;;; jischeck.el ������
;;
;; jischeck.el 19960827+19970214+19980406
;;     By TAMURA Kent <kent@muraoka.info.waseda.ac.jp>
;;      + akira yamada <akira@linux.or.jp>
;;      + Takashi Ishioka <ishioka@dad.eec.toshiba.co.jp>

;; JIS X 0208-1983 ��̵�����ϰ�(���ͤ� ISO-2022-JP �Ǥ���):
;;  1,2 Byte�ܤ� 0x00-0x20, 0x7f-0xff
;;  1 Byte��:  0x29-0x2f, 0x75-0x7e
;;
;; �٤����Ȥ���Ǥ�:
;;  222f-2239, 2242-2249, 2251-225b, 226b-2271, 227a-227d
;;  2321-232f, 233a-2340, 235b-2360, 237b-237e
;;  2474-247e,
;;  2577-257e,
;;  2639-2640, 2659-267e,
;;  2742-2750, 2772-277e,
;;  2841-287e,
;;  4f54-4f7e,
;;  7425-747e,
;;
;;;; ���ѽ����.

;;;; 1 byte �ܤ� 0x29-0x2f, 0x75-0x7e ��ʸ���ˤΤ��б�.
(or (if running-xemacs
	(defined-category-p ?@)
      (category-docstring ?@))
    (let ((page 41))
      (define-category ?@ "invalid japanese char category")
      (while (<= page 126)
	(if running-xemacs
	    (modify-category-entry `[japanese-jisx0208 ,page] ?@)
	  (modify-category-entry (make-char 'japanese-jisx0208 page) ?@))
	(setq page 
	      (if (= page 47) 117 (1+ page))))))

(defun text-adjust-codecheck (&optional from to)
  "̵����ʸ�������ɤ� text-adjust-codecheck-alarm ���֤�������.

�꡼�����λ��꤬���ä����Ϥ����ϰϤ�, �ʤ���� mark-paragraph �ˤ�ä�
����줿�ϰϤ��оݤˤ���."
  (interactive)
  (save-excursion
    (or (transient-region-active-p)
	(mark-paragraph))
    (text-adjust-codecheck-region (region-beginning) (region-end))))

(defun text-adjust-codecheck-buffer ()
  "�Хåե���Ǵؿ� text-adjust-jischeck ��¹Ԥ���."
  (interactive)
  (text-adjust-codecheck-region (point-min) (point-max)))

(defun text-adjust-codecheck-region (from to)
  "�꡼�������Ǵؿ� text-adjust-jischeck ��¹Ԥ���."
  (interactive "r")
  (text-adjust--replace text-adjust-rule-codecheck from to))


;;;; text-adjust-hankaku
(defun text-adjust-hankaku ()
  "���ѱѿ�ʸ����Ⱦ�Ѥˤ���.

�꡼�����λ��꤬���ä����Ϥ����ϰϤ�, �ʤ���� mark-paragraph �ˤ�ä�
����줿�ϰϤ��оݤˤ���."
  (interactive)
  (save-excursion
    (or (transient-region-active-p)
	(mark-paragraph))
    (text-adjust-hankaku-region (region-beginning) (region-end))))

(defun text-adjust-hankaku-buffer ()
  "�Хåե���Ǵؿ� text-adjust-hankaku ��¹Ԥ���."
  (interactive)
  (text-adjust-hankaku-region (point-min) (point-max)))

(defun text-adjust-hankaku-region (from to) 
  "�꡼�������Ǵؿ� text-adjust-hankaku ��¹Ԥ���."
  (interactive "r")
  (require 'japan-util)
  (save-excursion
    (let ((tmp-table (text-adjust--copy-char-table char-code-property-table)))
      (text-adjust--modify-char-table ?�� (list 'ascii "  "))
      (mapcar '(lambda (c) (text-adjust--modify-char-table c nil))
       (string-to-list text-adjust-hankaku-except))
      (japanese-hankaku-region from to t)
      (setq char-code-property-table 
	    (text-adjust--copy-char-table tmp-table)))))

(defun text-adjust--modify-char-table (range value)
  (if running-xemacs
      (put-char-table range value char-code-property-table)
    (set-char-table-range char-code-property-table range value)))

(defun text-adjust--copy-char-table (table)
  (if running-xemacs
      (copy-char-table table)
    (copy-sequence table)))


;;;; text-adjust-kutouten
(defun text-adjust-kutouten (&optional forcep)
  "���������Ѵ�����.
������ text-adjust-kuten-from ���� text-adjust-kuten-to ���ͤ�,
������ text-adjust-touten-from ���� text-adjust-touten-to ���ͤ��Ѵ�����.

�꡼�����λ��꤬���ä����Ϥ����ϰϤ�, �ʤ���� mark-paragraph �ˤ�ä�
����줿�ϰϤ��оݤˤ���."
  (interactive)
  (save-excursion
    (or (transient-region-active-p)
	(mark-paragraph))
    (text-adjust-kutouten-region (region-beginning) (region-end) forcep)))

(defun text-adjust-kutouten-buffer (&optional forcep)
  "�Хåե���Ǵؿ� text-adjust-kutouten ��¹Ԥ���."
  (interactive "P")
  (text-adjust-kutouten-region (point-min) (point-max) forcep))

(defun text-adjust-kutouten-region (from to &optional forcep)
  "�꡼�������Ǵؿ� text-adjust-kutouten ��¹Ԥ���."
  (interactive "r\nP")
  (text-adjust-kutouten-read-rule forcep)
  (text-adjust--replace text-adjust-rule-kutouten from to))

(defun text-adjust-kutouten-read-rule (&optional forcep)
  "�Ѵ���ζ����������򤹤�."
  (interactive)
  (if (and text-adjust-rule-kutouten (not forcep) (not (interactive-p)))
      text-adjust-rule-kutouten
    (make-local-variable 'text-adjust-rule-kutouten)
    (setq text-adjust-rule-kutouten
	  (symbol-value
	   (let ((kutouten-alist 
		  '(("kuten-zenkaku"  . text-adjust-rule-kutouten-zkuten)
		    ("zenkaku-kuten"  . text-adjust-rule-kutouten-zkuten)
		    ("����"           . text-adjust-rule-kutouten-zkuten)
		    ("period-zenkaku" . text-adjust-rule-kutouten-zperiod)
		    ("zenkaku-period" . text-adjust-rule-kutouten-zperiod)
		    ("����"           . text-adjust-rule-kutouten-zperiod)
		    ("period-hankaku" . text-adjust-rule-kutouten-hperiod)
		    ("hankaku-period" . text-adjust-rule-kutouten-hperiod)
		    (",."             . text-adjust-rule-kutouten-hperiod))))
	     (cdr (assoc
		   (completing-read "�������μ���: " kutouten-alist
				    nil t ",.")
		   kutouten-alist)))))))

;;;; text-adujst-space
(defun text-adjust-space ()
  "Ⱦ�ѱѿ������ܸ�δ֤˶������������.
text-adjust-japanese ��������줿���ܸ�ʸ���򼨤�����ɽ����,
text-adjust-ascii ��������줿Ⱦ�ѱѿ�ʸ���򼨤�����ɽ���Ȥδ֤�
�������������.

�꡼�����λ��꤬���ä����Ϥ����ϰϤ�, �ʤ���� mark-paragraph �ˤ�ä�
����줿�ϰϤ��оݤˤ���."
  (interactive)
  (save-excursion
    (or (transient-region-active-p)
	(mark-paragraph))
    (text-adjust-space-region (region-beginning) (region-end))))

(defun text-adjust-space-buffer () 
  "�Хåե���Ǵؿ� text-adjust-space ��¹Ԥ���."
  (interactive)
  (text-adjust-space-region (point-min) (point-max)))
  
(defun text-adjust-space-region (from to) 
  "�꡼�������Ǵؿ�text-adjust-space��¹Ԥ���."
  (interactive "r")
  (text-adjust--replace text-adjust-rule-space from to))


;;;; text-adjust-fill
(defun text-adjust-fill ()
  "�������Ǥβ��Ԥ�ͥ�褷��, fill-region ��¹Ԥ���.
�ƹԤ� text-adjust-fill-start ����, fill-column �ޤǤδ֤�,
text-adjust-fill-regexp ���Ǹ�˴ޤޤ�Ƥ���Ȥ���ǲ��Ԥ���.

�꡼�����λ��꤬���ä����Ϥ����ϰϤ�, �ʤ���� mark-paragraph �ˤ�ä�
����줿�ϰϤ��оݤˤ���."
  (interactive)
  (save-excursion
    (or (transient-region-active-p)
	(mark-paragraph))
    (text-adjust-fill-region (region-beginning) (region-end))))

(defun text-adjust-fill-buffer () 
  "�Хåե���Ǵؿ� text-adjust-fill ��¹Ԥ���."
  (interactive)
  (text-adjust-fill-region (point-min) (point-max)))
  
(defun text-adjust-fill-region (from to) 
  "�꡼�������Ǵؿ� text-adjust-fill ��¹Ԥ���."
  (interactive "r")
  (save-excursion
    (save-restriction
      (narrow-to-region from to)
      (let ((kinsoku-tmp kinsoku-ascii)
	    (prefix (if adaptive-fill-mode (fill-context-prefix from to) "")))
	(setq kinsoku-ascii t)
	(fill-region (point-min) (point-max))
	(goto-char (point-min))
	(while (/= (line-end-position) (point-max))
	  (move-to-column text-adjust-fill-start)
	  (if (and (re-search-forward
		    (concat "\\(" text-adjust-fill-regexp 
			    "\\) *[^" text-adjust-fill-regexp "]*$")
		    (line-end-position) t))
	      (progn
		(goto-char (match-end 1))
		(delete-horizontal-space)
		(if (eolp)
		    (beginning-of-line 2)
		  (progn
		    (insert (concat "\n" prefix))
		    (beginning-of-line)
		    )))
	    (beginning-of-line 2))
	  (narrow-to-region (point) (point-max))
	  (fill-region (point-min) to nil nil t)
	  (goto-char (point-min)))
	(delete-horizontal-space)
	(setq kinsoku-ascii kinsoku-tmp)))))


;;;; text-adjust engine
(defun text-adjust--replace (rule from to)
  (save-excursion
    (save-restriction
      (narrow-to-region from to)
      (goto-char (point-min))
      (let* ((rule-pattern 
	      (text-adjust--make-rule-pattern 
	       (append (cdr (assoc major-mode text-adjust-mode-skip-rule)) 
		       rule)))
	     (regexp (nth 0 rule-pattern))
	     (target (nth 1 rule-pattern))
	     (counts (nth 2 rule-pattern)))
	(while (re-search-forward regexp nil t)
	  (let ((n 1) (m 0) right-string)
	    ; �����ѥ�����ޤǤ������
	    (while (not (match-beginning n))
	      (setq n (+ n 3 (mapadd (nth m counts)))
		    m (1+ m)))
	    ; �����ѥ�������ִ�����
	    (let* ((tmp n)
		   (total-counts 
		    (cons n (mapcar (lambda (x) (setq tmp (+ tmp x 1)))
				    (nth m counts))))
		   (right-string (match-string (nth 2 total-counts))))
	      (replace-match 
	       (concat 
		;; �����ѥ�����κ�¦
		(match-string n)
		;; �����ѥ�����Τޤ��� (�ִ���ʬ)
		(mapconcat
		 (lambda (x) 
		   (if (stringp x) x
		     (match-string (+ (nth (1- (car x)) total-counts) 
				      (cdr x)))))
		 (nth m target) "")
		;; �����ѥ�����α�¦
		right-string))
	      ;; "��a��a" �Τ褦�˰�ʸ�����Ĥ��¤�Ǥ�������н�
	      (backward-char (length right-string))))))
      )))

(defun text-adjust--make-rule-pattern (rule)
  (let ((regexp (mapconcat 
		 (lambda (x) 
		   (format "\\(%s\\)\\(%s\\)\\(%s\\)"
			   (nth 0 (car x)) (nth 1 (car x)) (nth 2 (car x))))
		 rule "\\|"))
	(target (mapcar 
		 (lambda (x)
		   (text-adjust--parse-replace-string (nth 1 x)))
		 rule))
	(counts (mapcar
		 (lambda (x)
		   (list (count-string-match "\\\\(" (nth 0 (car x)))
			 (count-string-match "\\\\(" (nth 1 (car x)))
			 (count-string-match "\\\\(" (nth 2 (car x)))))
		 rule)))
    (list regexp target counts)))

(defun text-adjust--parse-replace-string (rule)
  (let ((n 0) m list)
    (while (string-match "\\([^{]*\\){\\([^}]+\\)}" rule n)
      (setq n (match-end 0))
      (let ((match1 (match-string 1 rule))
	    (match2 (match-string 2 rule)))
	(cond ((string-match "^[0-9]+\\(-[0-9]+\\)?$" match2)
	       (or (string= match1 "") (setq list (cons match1 list)))
	       (let* ((tmp (split-string match2 "-"))
		      (num (cons (string-to-number (car tmp))
				 (string-to-number (or (nth 1 tmp) "0")))))
		 (setq list (cons num list))))
	      (t
	       (setq list (cons match2 (cons match1 list)))))))
    (reverse (cons (substring rule n) list))))


(provide 'text-adjust)
; $Id: text-adjust.el,v 1.1.1.1 2002/08/25 14:24:48 komatsu Exp $
