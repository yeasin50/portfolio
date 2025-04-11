# Documentation for `projects.json` Structure

> This documentation explains the structure of a `projects.json` object. Each project contains essential information such as project details, media, and deployment links. Below is a breakdown of the keys and their usage:

<details>
<summary> Response Json </summary>

```json
{
  "version": 0,
  "updated_at": "2025-02-07T12:00:00Z",
  "data": [...holds project json]
}
```

- `updated_at`

  - **Type**: String (ISO 8601 Date)
  - **Description**: The creation date and time of the project.
  - **Example**: `"2025-01-01T00:00:00Z"`

- `data`
  - **Type**: List of `Project`

</details>

<details>
<summary> Project Json struct </summary>

```json
{
    "id": "6",
    "title": "Read me when",
    "description": "Quranic verses (ayah) based on mood, spreading Islamic Da'wah in a respectful way.",
    "category": "Flutter|Web",
    "roll": "Special",
    "created_at": "2025-01-01T00:00:00Z",
    "thumbnail": {
        "type": "image",
        "value": "read_me_when.png",
        "blur_hash": "LXMt?gS#?w,o%Lj=IpWGT}xDrVSh"
    },
    "deployed": "https://yeasin50.github.io/read_me_when/",
    "source": "https://github.com/yeasin50/read_me_when",
    "media": [
    {
        "title": "",
        "data": [
        {
            "type": "hover_play",
            "value": "read_me_when.gif",
            "blur_hash": "LXMt?gS#?w,o%Lj=IpWGT}xDrVSh"
        }
        ]
    }
    ],
    "tasks": [
        "Led and built an open-source app that displays Quranic verses for emotional and spiritual support.",
        "Added verse-sharing to help users connect and uplift each other."
    ]
},
```

</details>

### `Project` fields breakdown

- `id`

  - **Type**: String
  - **Description**: A unique identifier for the project.
  - **Example**: `"6"`

- `title`

  - **Type**: String
  - **Description**: The name or title of the project.
  - **Example**: `"Read me when"`

- `description`

  - **Type**: String
  - **Description**: A short description of the project that explains its purpose or function.
  - **Example**: `"Quranic verses (ayah) based on mood, spreading Islamic Da'wah in a respectful way."`

- `category`

  - **Type**: String
  - **Description**: The category or platform of the project (e.g., "Flutter", "Web").
  - **Example**: `"Flutter|Web"`

- `roll`

  - **Type**: String
  - **Description**: Specifies the special classification or role of the project (e.g., "Special", "Feature").
  - **Example**: `"Special"`

- `created_at`

  - **Type**: String (ISO 8601 Date)
  - **Description**: The creation date and time of the project.
  - **Example**: `"2025-01-01T00:00:00Z"`

- `thumbnail` (Type: `mediaItem`)

  - **Type**: Object
  - **Description**: Metadata for the thumbnail image associated with the project.

    - `type`: The type of the media, usually `image`,`hover_play`.
    - `value`: The filename or URL of the thumbnail image.
    - `blur_hash`: A string representing a blurred version of the image used as a placeholder before the actual image loads. generate from [blurha.sh](https://blurha.sh/)
    - **Example**:

      ```json
      {
        "type": "image",
        "value": "read_me_when.png",
        "blur_hash": "LXMt?gS#?w,o%Lj=IpWGT}xDrVSh"
      }
      ```

- `deployed`

  - **Type**: String (URL)
  - **Description**: The URL where the project is hosted or deployed.
  - **Example**: `"https://yeasin50.github.io/read_me_when/"`

- `source`

  - **Type**: String (URL)
  - **Description**: The URL to the project's source code repository (e.g., GitHub).
  - **Example**: `"https://github.com/yeasin50/read_me_when"`

- `media` (Type: `mediaGroup`)

  - **Type**: Array of Objects
  - **Description**: A list of media groups related to the project. Each `mediaGroup` contains one or more `mediaItem` objects.

    - `title`: The title of the media group (optional).
    - `data`: A list of `mediaItem` objects, where each object can have:
      - `type`: The type of media (e.g., `hover_play`, `video`, etc.).
      - `value`: The filename or URL of the media.
      - `blur_hash`: A blurred placeholder version of the media.
    - **Example**:

    ```json
    [
      {
        "title": "",
        "data": [
          {
            "type": "hover_play",
            "value": "read_me_when.gif",
            "blur_hash": "LXMt?gS#?w,o%Lj=IpWGT}xDrVSh"
          }
        ]
      }
    ]
    ```

- `show`
  - **Type**: bool
  - **Description**: default is true, if false item will hide on app/client side
