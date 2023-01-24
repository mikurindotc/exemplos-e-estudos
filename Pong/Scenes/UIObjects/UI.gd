extends CanvasLayer

func update_score_p1(score):
	$ScoreP1.text = "%02d" % score

func update_score_p2(score):
	$ScoreP2.text = "%02d" % score
