#!/bin/bash
html='yes'
stats='no'
sizes=()

for i in $(seq 1 154); do
	filename="ja-${i}.jpg"
	dirlead="/assets/images"
	size=$(file "${filename}" | grep --only-matching '[0-9]\+x[0-9]\+' | tr 'x' '/')
	if [ "$html" = 'yes' ]; then
		webpath="${dirlead}/engagement_photos_web/${filename}"
		fullpath="${dirlead}/engagement_photos_full/${filename}"
		mdimage="![${filename}](${webpath}){: style=\"aspect-ratio: ${size};\"}"
		mdlinked="[${mdimage}](${fullpath})"
		mdline="- ${mdlinked}"
		echo "$mdline"
	fi
	sizes+=($size)
done

# Thanks to https://stackoverflow.com/questions/54797475/how-to-remove-duplicate-elements-in-an-existing-array-in-bash/54797587#54797587
uniqsizes=()
while IFS= read -r -d '' x
do
	uniqsizes+=("$x")
done < <(printf "%s\0" "${sizes[@]}" | sort -uz)

if [ "$stats" = 'yes' ]; then
	echo ${sizes[@]}
	echo '---'
	echo ${uniqsizes[@]}
fi
