projection implementation in class ZBP_C_ZA_CONNECTIONS unique;
strict ( 2 );
use draft;
define behavior for ZC_ZA_CONNECTIONS alias Connections
use etag

{
  use create;
  use update;
  use delete;

  use action Edit;
  use action Activate;
  use action Discard;
  use action Resume;
  use action Prepare;
}