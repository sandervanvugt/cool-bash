#!/bin/bash
# substitution using pattern matching

for user in `cat users`
do
	user=${user//bob/lisa}
	echo $user >> newusers
done

cp users user.bak
mv newusers users
