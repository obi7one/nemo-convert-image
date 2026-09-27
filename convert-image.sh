#!/bin/bash
set -e

FORM=$(zenity --forms \
  --title="Convert image" \
  --text="" \
  --width=385 \
  --add-combo="Format" \
  --combo-values="PNG|JPG|WebP|TIFF|BMP|GIF" \
  --add-combo="Image Size" \
  --combo-values="Actual Size|Large|Medium|Small")

# Cancel or empty
[ -z "$FORM" ] && exit 0

FORMAT=$(echo "$FORM" | cut -d'|' -f1 | tr '[:upper:]' '[:lower:]')
SIZE=$(echo "$FORM"   | cut -d'|' -f2)

FILES=()
for file in "$@"; do
  [ -f "$file" ] && FILES+=("$file")
done

[ "${#FILES[@]}" -eq 0 ] && exit 0

case "$SIZE" in
  "Large")  GEOM="1920x1920>" ;;
  "Medium") GEOM="1280x1280>" ;;
  "Small")  GEOM="800x800>" ;;
  *)        GEOM="" ;;
esac

(
  echo "pulse"
  echo "# Starting conversion…"

  for file in "${FILES[@]}"; do
    filename="$(basename "$file")"
    echo "# Converting: $filename"

    base="${file%.*}"
    out="${base}.${FORMAT}"

    if [ -e "$out" ]; then
      n=1
      while [ -e "${base}_${n}.${FORMAT}" ]; do
        n=$((n + 1))
      done
      out="${base}_${n}.${FORMAT}"
    fi

    if [ -n "$GEOM" ]; then
      convert "$file" -resize "$GEOM" "$out"
    else
      convert "$file" "$out"
    fi
  done
) | zenity --progress \
  --title="Converting" \
  --width=385 \
  --pulsate \
  --auto-close \
  --cancel-label="Cancel"

[ $? -ne 0 ] && exit 0

