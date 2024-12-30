for file in links/*; do
	echo $file
	mv $file gallery-dl
	./process.sh
	for file in gallery-dl/*; do
		mv $file oldlinks
	done
done
