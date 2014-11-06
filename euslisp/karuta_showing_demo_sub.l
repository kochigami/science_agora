#!/usr/bin/env roseus

(ros::load-ros-manifest "science_agora")
(ros::roseus "character_subscriber")
(ros::roseus-add-msgs "std_msgs")

(require :nao-interface "/home/kochigami/ros/groovy/science_agora/euslisp/nao-interface-kochigami.l")

(setq *nao* (nao))
(setq *ni* (instance nao-interface :init))
(setq *name_data* nil)
(setq *name-list* nil)

(setq *start-position* #f(80.7701 11.1598 -46.4971 -59.764 7.46839 82.2691 -10.3736 45.965 59.5051 -6.94585 -14.3239 -4.48007 -39.6368 121.039 -67.9785 4.30665 -14.3239 4.48488 -39.9931 121.039 -67.97 -4.34702 0.788627 3.0738))

;;名前を聞いて                                                                 
(setq name_interview #f(82.0885 11.6872 -50.8917 -61.0823 6.32579 84.2027 -10.6373 50.0959 60.1203 -5.45169 -15.115 -4.74374 -40.4278 121.039 -67.9785 4.30665 -15.115 4.13332 -40.6963 121.039 -67.97 -4.34702 1.49175 2.45857))

(setq name_interview2 #f(82.0885 11.6872 -50.8917 -61.0823 6.32579 84.2027 -10.6373 50.0959 60.1203 -5.45169 -15.115 -4.74374 -40.4278 121.039 -67.9785 4.30665 -15.115 4.13332 -40.6963 121.039 -67.97 -4.34702 1.49175 2.45857))


(defclass making_newspaper_about_you_class
  :super propertied-object
  :slots (*name_data*)
  )

(defmethod making_newspaper_about_you_class
  (:init ()
	 (ros::subscribe "nao_learn_word" std_msgs::string #'send self :character-cb)
	 )
  ;; character-cb -> name-cb -> picture-cb

  (:character-cb (msg)
		 (let ((rand_num 0)
		       (rand_num2 0))
		   ;;別に"り"じゃなくて、"登録おわり"的な写真を用意する	 
		   (if (string= (send msg :data) "おしまい")
		       (progn
			 
			 ;;名前を呼ぶ機能をつけたい
			 ;;added 
			 (dolist (japanese-char *name-list*) 
			   (progn             
			     (if (string= japanese-char "あ")
				 (send *ni* :play-soundfile "/home/nao/wav_test/a.wav"))
			     (if (string= japanese-char "い")
				 (send *ni* :play-soundfile "/home/nao/wav_test/i.wav"))
			     (if (string= japanese-char "う")
				 (send *ni* :play-soundfile "/home/nao/wav_test/u.wav"))
			     (if (string= japanese-char "え")
				 (send *ni* :play-soundfile "/home/nao/wav_test/e.wav"))
			     (if (string= japanese-char "お")
				 (send *ni* :play-soundfile "/home/nao/wav_test/o.wav"))
			     (if (string= japanese-char "か")
				 (send *ni* :play-soundfile "/home/nao/wav_test/ka.wav"))
			     (if (string= japanese-char "き")
				 (send *ni* :play-soundfile "/home/nao/wav_test/ki.wav")
			       )
			     (if (string= japanese-char "く")
				 (send *ni* :play-soundfile "/home/nao/wav_test/ku.wav")
			       )
			     (if (string= japanese-char "け")
				 (send *ni* :play-soundfile "/home/nao/wav_test/ke.wav")
			       )
			     (if (string= japanese-char "こ")
				 (send *ni* :play-soundfile "/home/nao/wav_test/ko.wav")
			       )
			     (if (string= japanese-char "さ")
				 (send *ni* :play-soundfile "/home/nao/wav_test/sa.wav")
			       )
			     (if (string= japanese-char "し")
				 (send *ni* :play-soundfile "/home/nao/wav_test/si.wav"))
			     
			     (if (string= japanese-char "す")
				 (send *ni* :play-soundfile "/home/nao/wav_test/su.wav")
			       )
			     (if (string= japanese-char "せ")
				 (send *ni* :play-soundfile "/home/nao/wav_test/se.wav")
			       )
			     (if (string= japanese-char "そ")
				 (send *ni* :play-soundfile "/home/nao/wav_test/so.wav")
			       )
			     (if (string= japanese-char "た")
				 (send *ni* :play-soundfile "/home/nao/wav_test/ta.wav")
			       )
			     (if (string= japanese-char "ち")
				 (send *ni* :play-soundfile "/home/nao/wav_test/ti.wav")
			       )
			     (if (string= japanese-char "つ")
				 (send *ni* :play-soundfile "/home/nao/wav_test/tu.wav")
			       )
			     (if (string= japanese-char "て")
				 (send *ni* :play-soundfile "/home/nao/wav_test/te.wav")
			       )
			     (if (string= japanese-char "と")
				 (send *ni* :play-soundfile "/home/nao/wav_test/to.wav")
			       )
			     (if (string= japanese-char "な")
				 (send *ni* :play-soundfile "/home/nao/wav_test/na.wav")
			       )
			     (if (string= japanese-char "に")
				 (send *ni* :play-soundfile "/home/nao/wav_test/ni.wav")
			       )
			     (if (string= japanese-char "ぬ")
				 (send *ni* :play-soundfile "/home/nao/wav_test/nu.wav")
			       )
			     (if (string= japanese-char "ね")
				 (send *ni* :play-soundfile "/home/nao/wav_test/ne.wav"))
			     (if (string= japanese-char "の")
				 (send *ni* :play-soundfile "/home/nao/wav_test/no.wav")
			       )
			     (if (string= japanese-char "は")
				 (send *ni* :play-soundfile "/home/nao/wav_test/ha.wav")
			       )
			     (if (string= japanese-char "ひ")
				 (send *ni* :play-soundfile "/home/nao/wav_test/hi.wav")
			       )
			     (if (string= japanese-char "ふ")
				 (send *ni* :play-soundfile "/home/nao/wav_test/hu.wav")
			       )
			     (if (string= japanese-char "へ")
				 (send *ni* :play-soundfile "/home/nao/wav_test/he.wav")
			       )
			     (if (string= japanese-char "ほ")
				 (send *ni* :play-soundfile "/home/nao/wav_test/ho.wav")
			       )
			     (if (string= japanese-char "ま")
				 (send *ni* :play-soundfile "/home/nao/wav_test/ma.wav")
			       )
			     (if (string= japanese-char "み")
				 (send *ni* :play-soundfile "/home/nao/wav_test/mi.wav")
			       )
			     (if (string= japanese-char "む")
				 (send *ni* :play-soundfile "/home/nao/wav_test/mu.wav"))
			     (if (string= japanese-char "め")
				 (send *ni* :play-soundfile "/home/nao/wav_test/me.wav")
			       )
			     (if (string= japanese-char "も")
				 (send *ni* :play-soundfile "/home/nao/wav_test/mo.wav")
			       )
			     (if (string= japanese-char "や")
				 (send *ni* :play-soundfile "/home/nao/wav_test/ya.wav"))
			     (if (string= japanese-char "ゆ")
				 (send *ni* :play-soundfile "/home/nao/wav_test/yu.wav")
			       )
			     (if (string= japanese-char "よ")
				 (send *ni* :play-soundfile "/home/nao/wav_test/yo.wav")
			       )
			     (if (string= japanese-char "ら")
				 (send *ni* :play-soundfile "/home/nao/wav_test/ra.wav"))
			     (if (string= japanese-char "り")
				 (send *ni* :play-soundfile "/home/nao/wav_test/ri.wav")
			       )
			     (if (string= japanese-char "る")
				 (send *ni* :play-soundfile "/home/nao/wav_test/ru.wav")
			       )
			     (if (string= japanese-char "れ")
				 (send *ni* :play-soundfile "/home/nao/wav_test/re.wav"))
			     (if (string= japanese-char "ろ")
				 (send *ni* :play-soundfile "/home/nao/wav_test/ro.wav")
			       )
			     (if (string= japanese-char "わ")
				 (send *ni* :play-soundfile "/home/nao/wav_test/wa.wav")
			       )
			     (if (string= japanese-char "を")
				 (send *ni* :play-soundfile "/home/nao/wav_test/wo.wav"))
			     (if (string= japanese-char "ん")
				 (send *ni* :play-soundfile "/home/nao/wav_test/n.wav"))
			     
			     (setq *name-list* nil)
			     )
			   )
			 (send *ni* :play-soundfile "/home/nao/wav_test/san.wav")
			 (send *ni* :angle-vector-sequence (list name_interview name_interview2 *start-position*) (list 2500 3500 4500))
			 ;;(send *ni* :wait-interpolation)
			 ;;added end
			 (send *ni* :play-soundfile "/home/nao/wav_test/yorosikune.wav")
			 (unix:sleep 3)
			 (send *ni* :play-soundfile "/home/nao/wav_test/konna_kanji_de_yorosikune.wav")
			 )
		     
		     
		     
		     (progn
		       ;;added
			 (setq *name_data* (concatenate string *name_data* (send msg :data)))           
			 ;;added 
			 (setq *name-list* (append *name-list* (list (send msg :data))))
			 ;;added end 
			 ) 
		     )
		   )
		 )
  )

(setq m (instance making_newspaper_about_you_class :init))

(while (ros::ok)
  (ros::spin-once)
  )