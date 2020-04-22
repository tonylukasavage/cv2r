# Custom text

## usage

```
node .\bin\cv2r --patch custom-text
```

## Placeholders

You can use placeholders in the text that will be replaced by values in the game. Here's the list of supported placeholders:

* `<%= item %>`: This is the name of the item for all check actors. Bear in mind this can be up to 12 characters ("sacred flame") so it will take up a lot of chaarcters potentially
*

## Max text length

* **Merchants:** 12 characters per line, 2 lines. Bear in mind that if you use the `${item}` placeholder to insert the name of the item, you have VERY few characters to work with. But given that all merchants show the item’s icon, I think we can experiment with text that doesn’t directly mention the item.
* **Non-merchants:** 12 characters per line, 5 lines

**NOTE:** The custom-text patch will do its best to create space, new lines, hyphenated text, or new lines to make your text fit. If it still exceeds the bounds, the text will be modified or excluded from the patch.