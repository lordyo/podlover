% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/podlove_create_example_dl_ep.R
\name{podlove_create_example_dl_ep}
\alias{podlove_create_example_dl_ep}
\title{Create Random Podcast Download Data for One Episode}
\usage{
podlove_create_example_dl_ep(
  n_dls,
  dl_startdate,
  dl_enddate,
  media_file_id,
  seed = NULL
)
}
\arguments{
\item{n_dls}{number of downloads (rows) to generate}

\item{dl_startdate}{start date+time of downloads (episode release), formated as
a ymd string (e.g. "2019-01-31 12:31")}

\item{dl_enddate}{last download date+time}

\item{media_file_id}{id of the related media file}

\item{seed}{parameter to fix randomization via \code{set.seed()}}
}
\value{
a tibble with n_dl download times in seconds after release
}
\description{
This function generates a tibble with ficticious download data for one podcast
    episode. It is the core helper function for \code{podlove_create_example_downloads}.
    The function generates three kinds of data: a lognormal (long-tail) curve,
    a uniform (noise) curve, and several normal distributed peaks. All three
    distributions are mixed to provide approximate download simulation data.
}
\examples{
podlove_create_example_dl_ep(n_dls = 1000,
                             dl_startdate = "2019-01-01",
                             dl_enddate = "2019-12-31",
                             media_file_id = 105)

}
