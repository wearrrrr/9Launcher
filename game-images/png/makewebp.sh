for img in *.png; do
  cwebp -q 60 "$img" -o "../webp/${img%.png}.webp"
done
