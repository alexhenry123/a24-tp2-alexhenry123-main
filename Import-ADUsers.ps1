################################################################################
# TP2 - Création d'utilisateurs AD en lot
# 420-3T5-EM Automatisation de tâches
# Automne 2024
#
# Étudiant(e): Alex Henry
################################################################################

#Requires -Module ActiveDirectory

[CmdletBinding()]
Param(
    # TODO Paramètres de votre script ici
    [ValidateScript( { Test-Path $Path } )]
    [Parameter(Mandatory)][string] $Path
)

Function Write-Log {
    Param(
        # TODO Paramètres de votre fonction de log ici
        [Parameter(Mandatory)][string] $PathLog
    )

    # TODO Code de votre fonction de log ici
    function log {
    }
}

$ErrorActionPreference = "Stop"

# TODO Code de votre script ici...
try {
    $csv = Import-Csv -Path $Path
    foreach ($user in $csv) {
        $prenom = $user.Prenom
        $nom = $user.Nom
        $noempl = $user.NoEmpl
        $admin = $user.Admin
    } 
}
catch {
    
}    
