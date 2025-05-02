{{flutter_js}}
{{flutter_build_config}}

const loaderContainer = document.getElementsByClassName("loading_view")[0];

// Total animation + delay time (in ms)
const ANIMATION_DURATION = 4500; // Adjust if you change CSS timings

_flutter.loader.load({
  onEntrypointLoaded: async function(engineInitializer) {
    const appRunner = await engineInitializer.initializeEngine();

    // Wait for full animation to complete before fading out
    setTimeout(async () => {
      if (document.body.contains(loaderContainer)) {
        loaderContainer.style.transition = 'opacity 0.5s ease-out';
        loaderContainer.style.opacity = '0';

        // Wait for fade out to complete
        setTimeout(() => {
          if (document.body.contains(loaderContainer)) {
            document.body.removeChild(loaderContainer);
          }
        }, 500); // matches transition

      }

      // Now run the Flutter app AFTER all visual loading is done
      await appRunner.runApp();

    }, ANIMATION_DURATION); // wait before doing anything
  }
});
