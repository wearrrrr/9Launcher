for img in *.png; do
  cwebp -q 60 "$img" -o "${img%.png}.webp"
done