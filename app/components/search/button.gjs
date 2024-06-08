<template>
  <div class='button-component'>
    <div>
      <p class='note-message'>
        <b>Note:</b> If you have exhausted the search result without finding what best describes your item,
        click the below button to do a new search and refine your search term.
      </p>
    </div>
    <div class='center-display'>
      <button type="submit" class="pure-button pure-button-primary search-button">
        <svg xmlns="http://www.w3.org/2000/svg" width="18" height="18" fill="currentColor" class="bi bi-binoculars-fill" viewBox="0 0 16 16">
          <path d="M4.5 1A1.5 1.5 0 0 0 3 2.5V3h4v-.5A1.5 1.5 0 0 0 5.5 1zM7 4v1h2V4h4v.882a.5.5 0 0 0
            .276.447l.895.447A1.5 1.5 0 0 1 15 7.118V13H9v-1.5a.5.5 0 0 1.146-.354l.854-.853V9.5a.5.5
            0 0 0-.5-.5h-3a.5.5 0 0 0-.5.5v.793l.854.853A.5.5 0 0 1 7 11.5V13H1V7.118a1.5 1.5 0 0 1
            .83-1.342l.894-.447A.5.5 0 0 0 3 4.882V4zM1 14v.5A1.5 1.5 0 0 0 2.5
            16h3A1.5 1.5 0 0 0 7 14.5V14zm8 0v.5a1.5 1.5 0 0 0 1.5 1.5h3a1.5 1.5 0 0 0 1.5-1.5V14zm4-11H9v-.5A1.5 1.5 0 0 1 10.5
            1h1A1.5 1.5 0 0 1 13 2.5z"
          />
      </svg>
        New Search
      </button>
    </div>
  </div>
  <style>
    .button-component {
      font-family: var(--info);
    }

    .note-message {
      margin: auto;
      font-size: 0.6rem;
    }

    .search-button {
      margin: 0.5rem 0rem 0rem;
      border-radius: 0.4rem;
    }

  @media only screen and ( min-width: 710px ) {
    .note-message {
      width: 80%;
      margin: auto;
    }
  }
  </style>
</template>
