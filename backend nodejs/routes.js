const  routes  =  require ( ' next-routes ' ) (); // l'exigence renvoie une fonction. le second () est pour invoquer.

// Définir un nouveau mappage d'itinéraire
// arguments: le modèle à rechercher, quelle route du répertoire de la page nous voulons afficher.
itinéraires
    . add ( ' / ' , ' / index ' )
    . add ( ' / new ' , ' / new ' )
    . add ( ' / userProfile ' , ' / userProfile ' )
    . add ( ' / kitties /: address ' , ' / kitties / kittyProfile ' );


module . exportations  = routes;