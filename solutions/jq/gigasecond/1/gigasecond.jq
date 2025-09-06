1e9 as $gigasecond
| .moment as $input   # in the catch expr, "." is the error message, so we need to save this value
| $gigasecond +
    try   ($input + "Z"          | fromdateiso8601)   
    catch ($input + "T00:00:00Z" | fromdateiso8601)   
| todateiso8601
| rtrimstr("Z")