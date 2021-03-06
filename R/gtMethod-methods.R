#' show method for gtMethod
#' 
#' @param object \code{gtMethod}
#' show method for gtMethod
setMethod("show", signature = c("gtMethod"), definition = function(object) {
  # cat('Gating Method: ')
  cat(names(object))
  cat("(")
  chnls <- dims(object)
  cat(paste(paste(names(chnls), chnls, sep = "="), collapse = ","))
  cat(") \n")
#  cat(parameters(object))
})

#' show method for boolMethod
#' 
#' show method for boolMethod
#' @param object \code{boolMethod}
setMethod("show", signature = c("boolMethod"), definition = function(object) {
  cat(paste(class(object), "(", parameters(object), ")", sep = ""))
  cat("\n")
})

#' get gating method name
#' 
#' @param x \code{gtMethod} 
#' @aliases names,gtMethod-method
#' @examples 
#' \dontrun{
#' gt <- gatingTemplate(system.file("extdata/gating_template/tcell.csv",package = "openCyto"))
#' 
#' gtMthd <- gt_get_gate(gt, "/nonDebris/singlets",  "/nonDebris/singlets/lymph")
#' names(gtMthd) 
#' dims(gtMthd)
#' parameters(gtMthd)
#' isCollapse(gtMthd)
#' groupBy(gtMthd)
#' 
#' gtPop <- gt_get_nodes(gt, "/nonDebris/singlets/lymph/cd3/cd4+cd8-/CD38+")
#' names(gtPop)
#' alias(gtPop)
#' }
setMethod("names", signature = c("gtMethod"), definition = function(x) {
  x@name
})

#' get gating method dimensions
#' 
#' @param x \code{gtMethod}
#' @importFrom BiocGenerics dims
#' @aliases dims,gtMethod-method
setMethod("dims", signature = c("gtMethod"), definition = function(x) {
  dims <- strsplit(x@dims, ",")[[1]]
#  if (length(dims) == 1) 
#    dims <- c(NA, dims) else if (length(dims) != 2) 
#    stop("invalid dimensions!")
#  names(dims) <- c("xChannel", "yChannel")
  dims
})

#' get parameters of the gating method/function
#' 
#' @param object \code{gtMethod}
#' @importFrom flowCore parameters
#' @aliases parameters,gtMethod-method
setMethod("parameters", signature = c("gtMethod"), definition = function(object) {
  object@args
})

setGeneric("isCollapse",function(object,...)standardGeneric("isCollapse"))

#' get the flag that determines whether gating method is applied on collapsed data 
#' 
#' When TRUE, the flow data(multiple flowFrames) is collapsed into one and the gating method is applied on the collapsed data.
#' Once the gate is generated, it is thenreplicated and applied to the each single flowFrame.
#'   
#' @return \code{logical} 
#' @param object \code{gtMethod} 
#' @aliases isCollapse,gtMethod-method
setMethod("isCollapse", signature = c("gtMethod"), definition = function(object) {
      object@collapse
    })

setGeneric("groupBy",function(object,...)standardGeneric("groupBy"))
#' get the grouping variable for the gating method
#' 
#' When specified, the flow data is grouped by the grouping variable (column names in pData).
#' Within each group, when \code{isCollapse} is set to TRUE, the gating method is applied to the collapsed data.
#' Otherwise, it is done indepentently for each indiviudal sample(flowFrame).
#' Grouping variable is also used by \code{preprocessing method}.
#' 
#' @param object \code{gtMethod}
#' 
#' @aliases groupBy,gtMethod-method
setMethod("groupBy", signature = c("gtMethod"), definition = function(object) {
      object@groupBy
    })
