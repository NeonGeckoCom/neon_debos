# Clean Up Apt Packages
(echo "**** Clean Up All Apt Cache ****")
(cd /var/cache/apt/ && rm -rf archives/*)

# Clean Up Apt Packages
(echo "**** Clean Up All Pypi Cache ****")
(sudo pip3 cache purge)
