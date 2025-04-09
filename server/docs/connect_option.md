# The clarification before connecting me

> my philosophy on work, frequent asked question response and some details to reduce meta questions and make it efficient for me.

## Overview

The JSON structure consists of `ConnectOption`, describing different aspects of the user’s profile.

## Fields Breakdown

- `version`

  - **Type**: Integer
  - **Description**: Represents the version of the profile object.
  - **Example**: `0`

- `updated_at`

  - **Type**: String (ISO 8601 Date)
  - **Description**: The timestamp of the last update to the profile.
  - **Example**: `"2025-03-05T12:00:00Z"`

- `data`

  - **Type**: Array
  - **Description**: `ConnectOption` how can I help you? and my boundaries on different sector such as Software Development, Scholarship, Bug Hunting..

---

### `ConnectOption` json breakdown

example json

```json
{
  "type": "Software Development",
  "tldr": "I have worked on various types of projects for personal clients, companies, and government organizations...",
  "schedules":{...},
  "principles": [...],

}
```

- `type`

  - **Type**: String
  - **Description**: title/topic/category/Opportunity you are open for
  - **Example**: `Software Development`,`Bug hunting`,

- `tldr`

  - **Type**: String
  - **Description**: Little description why about the `type`

- `schedules`

  - **Type**: Map
  - **Description**: When user gonna be amiable, day-wise slot(WIP) for `time_slots`
  - **Example**:

    ```json
      "schedules": {
          "state": "available",
          "message": "I will be available from this date.",
          "time_slots": {
            dayName :[slots]
          }
        },
    ```

---

### `principles`

- **Type**: Array of Objects
- **Description**: Represents the user's principles, including categories like work style, preferences, technologies, and values. Each principle contains a category, a title, and a list of related items.

#### Subfields of each principle object:

- `category`

  - **Type**: String
  - **Description**: A category that represents the overarching theme of the principle (e.g., "concern", "ok", "not-ok").
  - **Example**: `"concern"`

- `title`

  - **Type**: String
  - **Description**: The title of the principle, providing a brief description of the workstyle, preference, or value associated with the category.
  - **Example**: `"Workstyle & Preferences"`

- `items`

  - **Type**: Array of Objects `principle_item`
  - **Description**: A list of items or subcategories that provide more detailed information about the principle. Each item consists of a `name` which is string and `data` which is list of string.

<details><summary> Example:</summary>

```json
"principles": [
    {
        "category": "concern",
        "title": "Workstyle & Preferences",
        "items": [
        {
            "name": "Flutter & Application Development",
            "data": [
            "My expertise shines in the Flutter framework.",
            "I prefer ThemeExtension over a static theme class.",
            "I like code generation but prefer writing small cases manually."
            ]
        }
        ]
    },
    {
        "category": "ok",
        "title": "Technologies I Work With",
        "items": [
        {
            "name": "Backend Development",
            "data": [
            "I work with Firebase, Supabase, and Serverpod.",
            "I use Golang with PostgreSQL."
            ]
        }
        ]
    }
]
```

</details>

---

### `schedules` (!Under construction)

- **Type**: Object
- **Description**: Contains the user's availability information, including their availability status, a custom message, and a breakdown of available time slots by day.

<details>
    <summary>  Subfields of `schedules`

</summary>

- [ ] ## handle timezone
  --
- **state**

  - **Type**: String
  - **Description**: Indicates the user's availability status (e.g., "available" or "unavailable").
  - **Example**: `"available"`

- **message**

  - **Type**: String
  - **Description**: A custom message explaining the user's availability or when they will be available.
  - **Example**: `"I will be available from this date."`

- **time_slots**
  - **Type**: Object
  - **Description**: An object representing available time slots for the user, organized by day of the week. Each key is the name of the day, and its value is an array of time slots (in a format such as `"HH:MM"`).
  - **Example**:
    ```json
    {
      "Monday": ["09:00-10:00"],
      "Wednesday": ["10:00", "15:00"]
    }
    ```

</details>
