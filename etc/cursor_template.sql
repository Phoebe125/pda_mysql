Declare _done boolean default False;
Declare _cur CURSOR FOR
	select x, y, ....;
Declare Continue Handler
	For Not Found SET _done := True;
OPEN _cur;
cur_loop: LOOP
	Fetch _cur into <var-X>, <var-Y>...; # cur는 fetch 한 곳에 머물러 있는다!
	IF _done THEN
		LEAVE cur_loop;
	END IF;
	...
END LOOP cur_loop;
CLOSE _cur;