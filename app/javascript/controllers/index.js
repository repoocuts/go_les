// Import and register all your controllers from the importmap under controllers/*

import {application} from "controllers/application"

// Eager load all controllers defined in the import map under controllers/**/*_controller
import {eagerLoadControllersFrom} from "@hotwired/stimulus-loading"

eagerLoadControllersFrom("controllers", application)

// Lazy load controllers as they appear in the DOM (remember not to preload controllers in import map!)
// import { lazyLoadControllersFrom } from "@hotwired/stimulus-loading"
// lazyLoadControllersFrom("controllers", application)

// Register controllers manually with example from app/components/named_component_controller.js:
// import NamedComponentController from 'named_component_controller';
// application.register(
//   'named-component',
//   NamedComponentController
// );
import PlayerSeasonRedCardsComponentController from "player/player_season_red_cards_component_controller";
import PlayerSeasonYellowCardsComponentController from "player/player_season_yellow_cards_component_controller";

application.register("player--player-season-yellow-cards-component", PlayerSeasonYellowCardsComponentController,);
application.register("player--player-season-red-cards-component", PlayerSeasonRedCardsComponentController);
