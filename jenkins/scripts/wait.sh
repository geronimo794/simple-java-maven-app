#!/usr/bin/env sh

# Countdown timer before next script
echo 'Count to 60s before local deployment is done...'
i=60
while [ $i -ge 1 ]
do
	sleep 1s
	echo $i
	i=$((i-=1))
done
echo 'Continue to public deploy heroku: https://hello-spring-jenkins.herokuapp.com/ ....'
